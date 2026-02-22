#!/usr/bin/env bash
# bootstrap.sh — cross-platform dev environment setup (macOS + Linux)
# Usage: bash bootstrap.sh [--dry-run]
#
# Tools installed:
#   zsh, neovim, tmux, kitty, fzf, ripgrep, jq,
#   tree-sitter CLI, npm, nvm, pyenv, python, uv
#
# Dotfiles cloned from $DOTFILES_REPO and linked via GNU Stow.
#
# Override defaults via env vars:
#   NVM_VERSION=0.40.1
#   PYTHON_VERSION=3.12.3
#   DOTFILES_REPO=https://github.com/50-Course/dotfiles
#   DOTFILES_DIR=$HOME/dotfiles

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/functions.sh"

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true && log::warn "Dry-run mode — no changes will be made"

# ─── Platform guard ───────────────────────────────────────────────────────────
if ! is_macos && ! is_linux; then
  log::error "Unsupported OS: $(uname). Only macOS and Linux are supported."
  exit 1
fi

is_macos && log::info "Platform: macOS ($(uname -m))"
is_linux && log::info "Platform: Linux ($(uname -m))"

is_linux && detect_pkg_manager

# ─── 0. XDG Base Directories ─────────────────────────────────────────────────
log::section "XDG Base Directories"
if $DRY_RUN; then
  log::info "[dry-run] Would create XDG dirs and write exports to ~/.zshrc"
else
  setup_xdg
  xdg::write_to_rc "$HOME/.zshrc"
fi

# ─── 1. macOS: Xcode CLI Tools ────────────────────────────────────────────────
if is_macos; then
  log::section "Xcode CLI Tools"
  if xcode-select -p &>/dev/null; then
    log::skip "Xcode CLI tools"
  else
    log::info "Installing Xcode CLI tools..."
    $DRY_RUN || xcode-select --install
    log::warn "Complete the dialog that appeared, then re-run this script."
    exit 0
  fi
fi

# ─── 2. Package manager bootstrap ────────────────────────────────────────────
log::section "Package manager"

if is_macos; then
  if has_cmd brew; then
    log::skip "Homebrew"
  else
    log::info "Installing Homebrew..."
    $DRY_RUN || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    $DRY_RUN || {
      if is_arm_mac; then eval "$(/opt/homebrew/bin/brew shellenv)"
      else           eval "$(/usr/local/bin/brew shellenv)"
      fi
    }
    log::success "Homebrew installed"
  fi
  $DRY_RUN || brew update --quiet

elif is_linux; then
  case "$PKG_MANAGER" in
    apt)
      log::info "Updating apt and installing build deps..."
      $DRY_RUN || sudo apt-get update -qq
      $DRY_RUN || sudo apt-get install -y \
        build-essential curl git wget ca-certificates \
        libssl-dev libffi-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev \
        libncursesw5-dev xz-utils tk-dev libxml2-dev \
        libxmlsec1-dev liblzma-dev 2>/dev/null
      log::success "apt ready"
      ;;
    dnf)
      log::info "Installing dnf build deps..."
      $DRY_RUN || sudo dnf groupinstall -y "Development Tools"
      $DRY_RUN || sudo dnf install -y \
        curl git wget openssl-devel bzip2-devel libffi-devel \
        zlib-devel readline-devel sqlite-devel xz-devel
      log::success "dnf ready"
      ;;
    pacman)
      log::info "Syncing pacman..."
      $DRY_RUN || sudo pacman -Sy --noconfirm base-devel curl git wget
      log::success "pacman ready"
      ;;
  esac
fi

# ─── 3. GNU Stow ─────────────────────────────────────────────────────────────
log::section "GNU Stow"
pkg::install stow stow stow stow

# ─── 4. zsh ───────────────────────────────────────────────────────────────────
log::section "zsh"

if is_macos; then
  brew::install zsh
  ZSH_PATH="$(brew --prefix)/bin/zsh"
elif is_linux; then
  pkg::install zsh zsh zsh zsh
  ZSH_PATH="$(which zsh)"
fi

if [[ "$SHELL" != "$ZSH_PATH" ]]; then
  log::info "Setting zsh ($ZSH_PATH) as default shell..."
  $DRY_RUN || {
    grep -qxF "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" | sudo tee -a /etc/shells
    chsh -s "$ZSH_PATH"
  }
  log::success "Default shell set to $ZSH_PATH (takes effect on next login)"
else
  log::skip "zsh is already default shell"
fi

# ─── 5. kitty ────────────────────────────────────────────────────────────────
log::section "kitty"

if is_macos; then
  brew::cask_install kitty
elif is_linux; then
  if has_cmd kitty; then
    log::skip "kitty"
  else
    log::info "Installing kitty via official installer..."
    $DRY_RUN || curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    $DRY_RUN || {
      ln -sf "$HOME/.local/kitty.app/bin/kitty"  "$HOME/.local/bin/kitty"
      ln -sf "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/kitten"
    }
    log::success "kitty installed"
  fi
fi

# ─── 6. tmux ─────────────────────────────────────────────────────────────────
log::section "tmux"
pkg::install tmux tmux tmux tmux

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ -d "$TPM_DIR" ]]; then
  log::skip "TPM"
else
  log::info "Installing TPM..."
  $DRY_RUN || git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  log::success "TPM installed"
fi

# ─── 7. Neovim ───────────────────────────────────────────────────────────────
log::section "Neovim"

if is_macos; then
  brew::install neovim
elif is_linux; then
  if has_cmd nvim; then
    log::skip "neovim"
  else
    log::info "Installing Neovim (latest stable) from GitHub releases..."
    $DRY_RUN || {
      curl -L "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz" \
        -o /tmp/nvim.tar.gz
      sudo tar -C /opt -xzf /tmp/nvim.tar.gz
      sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
      rm /tmp/nvim.tar.gz
    }
    log::success "neovim installed"
  fi
fi

# ─── 8. fzf ──────────────────────────────────────────────────────────────────
log::section "fzf"
pkg::install fzf fzf fzf fzf

if is_macos; then
  FZF_INSTALL="$(brew --prefix)/opt/fzf/install"
  [[ -f "$FZF_INSTALL" ]] && {
    log::info "Configuring fzf shell integrations..."
    $DRY_RUN || "$FZF_INSTALL" --key-bindings --completion --no-update-rc --no-bash --no-fish
    log::success "fzf key bindings configured"
  }
elif is_linux; then
  FZF_SHARE="/usr/share/doc/fzf/examples"
  if [[ -f "$FZF_SHARE/key-bindings.zsh" ]]; then
    $DRY_RUN || {
      append_if_missing "source $FZF_SHARE/key-bindings.zsh" "$HOME/.zshrc"
      append_if_missing "source $FZF_SHARE/completion.zsh"   "$HOME/.zshrc"
    }
    log::success "fzf shell integrations added to ~/.zshrc"
  fi
fi

# ─── 9. ripgrep ──────────────────────────────────────────────────────────────
log::section "ripgrep"
pkg::install ripgrep ripgrep ripgrep ripgrep

# ─── 10. jq ──────────────────────────────────────────────────────────────────
log::section "jq"
pkg::install jq jq jq jq

# ─── 11. tree-sitter CLI ─────────────────────────────────────────────────────
log::section "tree-sitter CLI"
pkg::install tree-sitter "tree-sitter-cli" "tree-sitter-cli" "tree-sitter"

if ! has_cmd tree-sitter; then
  if has_cmd npm; then
    log::info "Falling back: installing tree-sitter via npm..."
    $DRY_RUN || npm install -g tree-sitter-cli
    log::success "tree-sitter installed via npm"
  elif has_cmd cargo; then
    log::info "Falling back: installing tree-sitter via cargo..."
    $DRY_RUN || cargo install tree-sitter-cli
    log::success "tree-sitter installed via cargo"
  else
    log::warn "tree-sitter not installed — run: npm i -g tree-sitter-cli  (after node is set up)"
  fi
fi

# ─── 12. nvm → node → npm ────────────────────────────────────────────────────
log::section "nvm → node → npm"

NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

if [[ -d "$NVM_DIR" ]]; then
  log::skip "nvm"
else
  log::info "Installing nvm v${NVM_VERSION}..."
  $DRY_RUN || curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash
  log::success "nvm ${NVM_VERSION} installed"
fi

export NVM_DIR
$DRY_RUN || source_file_if_exists "$NVM_DIR/nvm.sh"

if $DRY_RUN; then
  log::info "[dry-run] Would install Node ${NODE_LTS} via nvm"
elif has_cmd nvm; then
  log::info "Installing Node ${NODE_LTS}..."
  nvm install "${NODE_LTS}"
  nvm use "${NODE_LTS}"

  # Resolve the actual version string (e.g. v24.1.0) before aliasing. --lts is a valid flag for `nvm install/use` but not for `nvm alias`.
  RESOLVED_NODE_VERSION="$(node -v)"
  nvm alias default "${RESOLVED_NODE_VERSION}"
  log::success "Node ${RESOLVED_NODE_VERSION} active; npm $(npm -v)"
else
  log::warn "nvm not in this session — run 'nvm install ${NODE_LTS}' after restarting your shell"
fi

# ─── 13. pyenv → python + uv ─────────────────────────────────────────────────
log::section "pyenv"

if is_macos; then
  brew::install pyenv
elif is_linux; then
  if has_cmd pyenv; then
    log::skip "pyenv"
  else
    log::info "Installing pyenv via pyenv-installer..."
    $DRY_RUN || curl -fsSL https://pyenv.run | bash
    log::success "pyenv installed"
  fi
fi

ZSHRC="$HOME/.zshrc"
$DRY_RUN || {
  append_if_missing 'export PYENV_ROOT="$HOME/.pyenv"'    "$ZSHRC"
  append_if_missing 'export PATH="$PYENV_ROOT/bin:$PATH"' "$ZSHRC"
  append_if_missing 'eval "$(pyenv init -)"'              "$ZSHRC"
}

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
$DRY_RUN || eval "$(pyenv init -)" 2>/dev/null || true

if $DRY_RUN; then
  log::info "[dry-run] Would install Python ${PYTHON_VERSION} via pyenv"
elif has_cmd pyenv; then
  if pyenv versions --bare | grep -q "^${PYTHON_VERSION}$"; then
    log::skip "Python ${PYTHON_VERSION}"
  else
    log::info "Installing Python ${PYTHON_VERSION} (this may take a moment)..."
    pyenv install "${PYTHON_VERSION}"
    log::success "Python ${PYTHON_VERSION} installed"
  fi
  pyenv global "${PYTHON_VERSION}"
  log::success "Python $(python3 --version) set as global"
else
  log::warn "pyenv not in PATH — install Python manually after restarting your shell"
fi

log::section "uv"
if has_cmd uv; then
  log::skip "uv"
else
  log::info "Installing uv..."
  $DRY_RUN || curl -LsSf https://astral.sh/uv/install.sh | sh
  log::success "uv installed"
fi

# ─── 14. Dotfiles via GNU Stow ───────────────────────────────────────────────
log::section "Dotfiles (GNU Stow)"

if $DRY_RUN; then
  log::info "[dry-run] Would clone ${DOTFILES_REPO} → ${DOTFILES_DIR}"
  log::info "[dry-run] Would stow: zsh tmux kitty nvim gitconfig bin"
else
  # Clone or update
  if [[ -d "${DOTFILES_DIR}/.git" ]]; then
    log::info "Dotfiles already cloned — pulling latest..."
    git -C "$DOTFILES_DIR" pull --ff-only && log::success "Dotfiles updated"
  else
    log::info "Cloning dotfiles from ${DOTFILES_REPO}..."
    git clone --recurse-submodules "$DOTFILES_REPO" "$DOTFILES_DIR"
    log::success "Dotfiles cloned to ${DOTFILES_DIR}"
  fi

  # Stow each package.
  # - vim  → ~/.config/nvim       (active neovim config)
  # - kitty          → ~/.config/kitty
  # - zsh            → ~/.zshrc / zsh files
  # - tmux           → ~/.tmux.conf (or ~/.config/tmux depending on your layout)
  # - gitconfig      → ~/.gitconfig
  # - bin            → ~/bin (personal scripts)
  #
  # nvim2023 and vim are legacy configs — skipped intentionally.
  # Add/remove packages below as your repo evolves.
  stow::link_all "$DOTFILES_DIR" \
    zsh \
    tmux \
    kitty \
    vim \
    gitconfig \
    bin
fi

# ─── 15. Wire remaining shell init into .zshrc ───────────────────────────────
log::section "Finalising ~/.zshrc"
ZSHRC="$HOME/.zshrc"

$DRY_RUN || {
  # Homebrew (macOS only — Linux manages PATH differently)
  if is_macos; then
    if is_arm_mac; then
      append_if_missing 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$ZSHRC"
    else
      append_if_missing 'eval "$(/usr/local/bin/brew shellenv)"'    "$ZSHRC"
    fi
  fi

  # nvm
  append_if_missing 'export NVM_DIR="$HOME/.nvm"'                                        "$ZSHRC"
  append_if_missing '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'                   "$ZSHRC"
  append_if_missing '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' "$ZSHRC"

  # fzf (macOS — the install script writes ~/.fzf.zsh)
  if is_macos; then
    append_if_missing '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' "$ZSHRC"
  fi

  log::success "~/.zshrc finalised"
}

# ─── 16. Version Control Managers ─────────────────────────────────────────────────────────────────────
log::section "Version Control Managers"
if has_cmd git; then
    log::skip "git is already installed"
else
    log::info "Installing git..."
    if is_macos; then
        brew::install git
    elif is_linux; then
        pkg::install git git git git
    fi
    log::success "git installed"
fi

if has_cmd gh; then
    log::skip "GitHub CLI is already installed"
else
    log::info "Installing GitHub CLI..."
    if is_macos; then
        brew::install gh
    elif is_linux; then
        pkg::install gh gh gh gh
    fi
    log::success "GitHub CLI installed"
fi

if has_cmd glab; then
    log::skip "GitLab CLI is already installed"
else
    log::info "Installing GitLab CLI..."
    if is_macos; then
        brew::install glab
    elif is_linux; then
        pkg::install glab glab glab glab
    fi
    log::success "GitLab CLI installed"
fi


# ─── Done ─────────────────────────────────────────────────────────────────────
log::section "All done"
echo -e "${GREEN}${BOLD}"
echo "  Your environment is ready. Next steps:"
echo ""
echo "  1. Restart your terminal (exec zsh) to pick up all PATH and env changes."
echo "  2. Open tmux → press <prefix>+I to install TPM plugins."
echo "  3. Launch Neovim — lazy.nvim/packer will auto-install on first open."
echo "  4. To re-link dotfiles after pulling changes:"
echo "     cd ${DOTFILES_DIR} && stow --restow --no-folding <package>"
echo -e "${RESET}"
