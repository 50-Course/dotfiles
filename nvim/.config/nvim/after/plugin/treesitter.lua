require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "htmldjango", "lua", "vim", "python", "rust", },

  sync_install = false,
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  highlight = {
    enable = true,

    disable = {},

    additional_vim_regex_highlighting = false,
  },
  indent = {
      enable = true,
      disable = {}
  },
}
