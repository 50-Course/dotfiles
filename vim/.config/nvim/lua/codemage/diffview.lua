--- Module to define all configurations regarding DiffView
local M = {}

local diffview = require("diffview")
local actions = require("diffview.actions")
local map = vim.keymap.set

--- Keybinds for vimdiff navigation
function M.setup_vimdiff_keymaps()
    --     So from the documentation, yeah, we can do:
    --     Additionally there are mappings for operating directly on the conflict
    -- markers:
    --   • `<leader>co`: Choose the OURS version of the conflict.
    --   • `<leader>ct`: Choose the THEIRS version of the conflict.
    --   • `<leader>cb`: Choose the BASE version of the conflict.
    --   • `<leader>ca`: Choose all versions of the conflict (effectively
    --     just deletes the markers, leaving all the content).
    --   • `dx`: Choose none of the versions of the conflict (delete the
    --     conflict region).
end

require("diffview").setup({
    keymaps = {
        disable_defaults = false,
        view = {
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            {
                "n",
                "<tab>",
                actions.select_next_entry,
                { desc = "Open the diff for the next file" },
            },
            {
                "n",
                "<s-tab>",
                actions.select_prev_entry,
                { desc = "Open the diff for the previous file" },
            },
            {
                "n",
                "[F",
                actions.select_first_entry,
                { desc = "Open the diff for the first file" },
            },
            {
                "n",
                "]F",
                actions.select_last_entry,
                { desc = "Open the diff for the last file" },
            },
            {
                "n",
                "gf",
                actions.goto_file_edit,
                { desc = "Open the file in the previous tabpage" },
            },
            {
                "n",
                "<C-w><C-f>",
                actions.goto_file_split,
                { desc = "Open the file in a new split" },
            },
            {
                "n",
                "<C-w>gf",
                actions.goto_file_tab,
                { desc = "Open the file in a new tabpage" },
            },
            {
                "n",
                "<leader>e",
                actions.focus_files,
                { desc = "Bring focus to the file panel" },
            },
            {
                "n",
                "<leader>b",
                actions.toggle_files,
                { desc = "Toggle the file panel." },
            },
            {
                "n",
                "g<C-x>",
                actions.cycle_layout,
                { desc = "Cycle through available layouts." },
            },
            {
                "n",
                "[x",
                actions.prev_conflict,
                { desc = "In the merge-tool: jump to the previous conflict" },
            },
            {
                "n",
                "]x",
                actions.next_conflict,
                { desc = "In the merge-tool: jump to the next conflict" },
            },
            {
                "n",
                "<leader>co",
                actions.conflict_choose("ours"),
                { desc = "Choose the OURS version of a conflict" },
            },
            {
                "n",
                "<leader>ct",
                actions.conflict_choose("theirs"),
                { desc = "Choose the THEIRS version of a conflict" },
            },
            {
                "n",
                "<leader>cb",
                actions.conflict_choose("base"),
                { desc = "Choose the BASE version of a conflict" },
            },
            {
                "n",
                "<leader>ca",
                actions.conflict_choose("all"),
                { desc = "Choose all the versions of a conflict" },
            },
            {
                "n",
                "dx",
                actions.conflict_choose("none"),
                { desc = "Delete the conflict region" },
            },
            {
                "n",
                "<leader>cO",
                actions.conflict_choose_all("ours"),
                {
                    desc = "Choose the OURS version of a conflict for the whole file",
                },
            },
            {
                "n",
                "<leader>cT",
                actions.conflict_choose_all("theirs"),
                {
                    desc = "Choose the THEIRS version of a conflict for the whole file",
                },
            },
            {
                "n",
                "<leader>cB",
                actions.conflict_choose_all("base"),
                {
                    desc = "Choose the BASE version of a conflict for the whole file",
                },
            },
            {
                "n",
                "<leader>cA",
                actions.conflict_choose_all("all"),
                {
                    desc = "Choose all the versions of a conflict for the whole file",
                },
            },
            {
                "n",
                "dX",
                actions.conflict_choose_all("none"),
                { desc = "Delete the conflict region for the whole file" },
            },
        },
    },
})

return M
