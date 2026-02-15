require("diagram").setup({
    integrations = {
        require("diagram.integrations.markdown"),
    },
    renderer_options = {
        mermaid = {
            theme = "forest",
        },
        plantuml = {
            charset = "utf-8",
        },
        d2 = {
            theme_id = 1,
        },
        gnuplot = {
            theme = "dark",
            size = "800,600",
        },
    },
    keys = {
        {
            "<localleader>sd", -- or any key you prefer
            function()
                require("diagram").show_diagram_hover()
            end,
            mode = "n",
            ft = { "markdown" },
            desc = "Show diagram in new tab",
        },
    },
})
