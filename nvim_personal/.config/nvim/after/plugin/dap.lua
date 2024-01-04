local dapui = require("dapui")
local dap = require("dap")

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dapui.setup({
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
    },
    sidebar = {
        elements = {
            -- You can change the order of elements in the sidebar
            "scopes",
            "breakpoints",
            "stacks",
            "watches",
        },
        width = 30,
        position = "left", -- Can be "left" or "right"
    },
    tray = {
        elements = { "repl" },
        height = 10,
        position = "bottom", -- Can be "bottom" or "top"
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
})

vim.keymap.set(
    "n",
    "<leader>b",
    '<cmd>lua require"dap".toggle_breakpoint()<CR>'
)
vim.keymap.set(
    "n",
    "<leader>B",
    '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>'
)
vim.keymap.set(
    "n",
    "<leader>lp",
    '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>'
)
vim.keymap.set("n", "<leader>dr", '<cmd>lua require"dap".repl.open()<CR>')
vim.keymap.set("n", "<leader>dl", '<cmd>lua require"dap".run_last()<CR>')
vim.keymap.set("n", "<leader>dc", '<cmd>lua require"dap".continue()<CR>')
vim.keymap.set(
    "n",
    "<leader>di",
    '<cmd>lua require"dap.ui.variables".hover()<CR>'
)
vim.keymap.set(
    "n",
    "<leader>ds",
    '<cmd>lua require"dap.ui.variables".scopes()<CR>'
)
vim.keymap.set(
    "n",
    "<leader>de",
    '<cmd>lua require"dap".set_exception_breakpoints({"all"})<CR>'
)
vim.keymap.set(
    "n",
    "<leader>da",
    '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>'
)
vim.keymap.set("n", "<leader>do", '<cmd>lua require"dap".step_over()<CR>')
vim.keymap.set("n", "<leader>di", '<cmd>lua require"dap".step_into()<CR>')
vim.keymap.set("n", "<leader>du", '<cmd>lua require"dap".step_out()<CR>')
