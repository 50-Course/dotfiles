#!/usr/bin/env bash
# functions.sh — shared helper functions for bootstrap.sh

# ─── Colors ───────────────────────────────────────────────────────────────────
RESET="\033[0m"
BOLD="\033[1m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
DIM="\033[2m"

# ─── Logging ──────────────────────────────────────────────────────────────────
log::info()    { echo -e "${CYAN}${BOLD}  →${RESET} $*"; }
log::success() { echo -e "${GREEN}${BOLD}  ✓${RESET} $*"; }
log::warn()    { echo -e "${YELLOW}${BOLD}  ⚠${RESET} $*"; }
log::error()   { echo -e "${RED}${BOLD}  ✗${RESET} $*" >&2; }
log::section() { echo -e "\n${BOLD}${CYAN}══ $* ${RESET}${DIM}$(printf '═%.0s' {1..40})${RESET}\n"; }
log::skip()    { echo -e "${DIM}  ~ $* (already installed, skipping)${RESET}"; }

# ─── Platform checks ──────────────────────────────────────────────────────────
is_macos()    { [[ "$(uname)" == "Darwin" ]]; }
is_linux()    { [[ "$(uname)" == "Linux" ]]; }
has_cmd()     { command -v "$1" &>/dev/null; }
is_arm_mac()  { is_macos && [[ "$(uname -m)" == "arm64" ]]; }

# Detect Linux package manager — sets PKG_MANAGER once
detect_pkg_manager() {
  if is_linux; then
    if has_cmd apt-get;  then PKG_MANAGER="apt"
    elif has_cmd dnf;    then PKG_MANAGER="dnf"
    elif has_cmd pacman; then PKG_MANAGER="pacman"
    else
      log::error "No supported package manager found (apt, dnf, pacman). Exiting."
      exit 1
    fi
    log::info "Detected package manager: ${PKG_MANAGER}"
  fi
}

# ─── Cross-platform package install ──────────────────────────────────────────
# pkg::install <brew-name> [apt-name] [dnf-name] [pacman-name]
# Falls back to brew-name for each platform arg if omitted.
pkg::install() {
  local brew_name="$1"
  local apt_name="${2:-$1}"
  local dnf_name="${3:-$1}"
  local pac_name="${4:-$1}"

  if is_macos; then
    brew::install "$brew_name"
  elif is_linux; then
    case "$PKG_MANAGER" in
      apt)    linux::apt_install    "$apt_name" ;;
      dnf)    linux::dnf_install    "$dnf_name" ;;
      pacman) linux::pacman_install "$pac_name" ;;
    esac
  fi
}

# ─── Homebrew helpers ─────────────────────────────────────────────────────────
brew::install() {
  local pkg="$1"
  if brew list --formula 2>/dev/null | grep -q "^${pkg}$"; then
    log::skip "$pkg"
  else
    log::info "Installing $pkg via brew..."
    brew install "$pkg" && log::success "$pkg installed"
  fi
}

brew::cask_install() {
  local cask="$1"
  if brew list --cask 2>/dev/null | grep -q "^${cask}$"; then
    log::skip "$cask (cask)"
  else
    log::info "Installing $cask via brew cask..."
    brew install --cask "$cask" && log::success "$cask installed"
  fi
}

# ─── Linux package helpers ────────────────────────────────────────────────────
linux::apt_install() {
  local pkg="$1"
  if dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "install ok installed"; then
    log::skip "$pkg"
  else
    log::info "Installing $pkg via apt..."
    sudo apt-get install -y "$pkg" && log::success "$pkg installed"
  fi
}

linux::dnf_install() {
  local pkg="$1"
  if rpm -q "$pkg" &>/dev/null; then
    log::skip "$pkg"
  else
    log::info "Installing $pkg via dnf..."
    sudo dnf install -y "$pkg" && log::success "$pkg installed"
  fi
}

linux::pacman_install() {
  local pkg="$1"
  if pacman -Q "$pkg" &>/dev/null; then
    log::skip "$pkg"
  else
    log::info "Installing $pkg via pacman..."
    sudo pacman -S --noconfirm "$pkg" && log::success "$pkg installed"
  fi
}

# ─── XDG Base Directory helpers ───────────────────────────────────────────────
# macOS doesn't set XDG vars by default; we establish them consistently
# on both platforms so tools like nvim, tmux, kitty resolve configs from
# ~/.config regardless of OS.
setup_xdg() {
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
  export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
  export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
  export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

  mkdir -p \
    "$XDG_CONFIG_HOME" \
    "$XDG_DATA_HOME" \
    "$XDG_CACHE_HOME" \
    "$XDG_STATE_HOME" \
    "$HOME/.local/bin"

  log::success "XDG dirs ready:"
  log::info    "  CONFIG → $XDG_CONFIG_HOME"
  log::info    "  DATA   → $XDG_DATA_HOME"
  log::info    "  CACHE  → $XDG_CACHE_HOME"
  log::info    "  STATE  → $XDG_STATE_HOME"
}

xdg::write_to_rc() {
  local rc="$1"
  append_if_missing 'export XDG_CONFIG_HOME="$HOME/.config"'     "$rc"
  append_if_missing 'export XDG_DATA_HOME="$HOME/.local/share"'  "$rc"
  append_if_missing 'export XDG_CACHE_HOME="$HOME/.cache"'       "$rc"
  append_if_missing 'export XDG_STATE_HOME="$HOME/.local/state"' "$rc"
  append_if_missing 'export PATH="$HOME/.local/bin:$PATH"'       "$rc"
}

# ─── GNU Stow helpers ─────────────────────────────────────────────────────────
# stow::link <dotfiles_dir> <package>
#   Stows a single package from the dotfiles dir into $HOME.
#   Uses --restow so re-running is always safe (unlinks then relinks).
#   Uses --no-folding so individual files are symlinked, not whole dirs —
#   this keeps XDG dirs clean and lets other tools write into ~/.config/<tool>
#   without the whole dir being a symlink.
stow::link() {
  local dotfiles_dir="$1"
  local package="$2"

  if [[ ! -d "${dotfiles_dir}/${package}" ]]; then
    log::warn "stow package '${package}' not found in ${dotfiles_dir}, skipping"
    return 0
  fi

  log::info "Stowing ${package}..."
  stow \
    --dir="$dotfiles_dir" \
    --target="$HOME" \
    --restow \
    --no-folding \
    "$package" \
  && log::success "${package} stowed → $HOME"
}

# stow::link_all <dotfiles_dir> <package> [package ...]
#   Stow multiple packages in one call.
stow::link_all() {
  local dotfiles_dir="$1"
  shift
  for pkg in "$@"; do
    stow::link "$dotfiles_dir" "$pkg"
  done
}

# ─── Shell helpers ────────────────────────────────────────────────────────────
append_if_missing() {
  local line="$1"
  local file="$2"
  grep -qxF "$line" "$file" 2>/dev/null || echo "$line" >> "$file"
}

source_file_if_exists() {
  [[ -f "$1" ]] && source "$1"
}

# ─── Version pins (override via env before running bootstrap.sh) ──────────────
NVM_VERSION="${NVM_VERSION:-0.40.1}"
PYTHON_VERSION="${PYTHON_VERSION:-3.12.3}"
NODE_LTS="${NODE_LTS:---lts}"
DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/50-Course/dotfiles}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
