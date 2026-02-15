-- Two different functions one to set transparency and another to set colorscheme
function applyBgColor(color)
  if not color then print("Colorscheme is not present, defaulting to a colorscheme") end
  color = color or "tokyonight"
  vim.cmd.colorscheme(color)
end

applyBgColor()

-- For Vim's own transparent background
-- I'm using rose-pine as it matches well with Kitty Opacity settings
--
-- Rose-pine (https://github.com/rose-pine/neovim)
if vim.cmd.colorscheme == "rose-pine" then
  local _, rose_pine = pcall(require, "rose-pine")

  rose_pine.setup({
    disable_background = true,
  })

  vim.cmd("colorscheme " .. rose_pine)
end

-- Make background Transparent
function flakesMode()
  -- essentially, we set the background, full transparency
  --
  -- Vim refers to the current window as `Normal` and floating windows
  -- as `NormalFloat`
  --
  -- for more information, seek the documentation `:h `
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
