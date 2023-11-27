local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {}) -- search git files
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
-- Find some string
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, {})

vim.keymap.set("n", "<leader>fb", function()
    builtin.buffers()
end, {})

--- Allows us to modify the way telescope acts upon an active buffer
local buffnr_opts = {}

-- Disable previewer for the telescope buffer
buffnr_opts.curr_bufnr = function()
    local opts = require("telescope.themes").get_dropdown({
        height = 30,
        previewer = false,
    })
    require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

return buffnr_opts
