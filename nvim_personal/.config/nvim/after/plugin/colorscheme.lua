-- Two different functions one to set transparency and another to set colorscheme
function applyBgColor(color)
    color = color or "tokyonight"
    vim.cmd.colorscheme(color)
end

applyBgColor()

-- Make background Transparent
function showbg()
    -- essentially, we set the background, full transparency
    --
    -- Vim refers to the current window as `Normal` and floating windows
    -- as `NormalFloat`
    --
    -- for more information, seek the documentation `:h `
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.cmd("colorscheme rose-pine", { disable_background = true })
end
