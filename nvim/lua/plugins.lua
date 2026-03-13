
return {


{
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    -- mason
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "bashls" },
    })

    -- cmp
    local cmp = require("cmp")
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      },
    })

    -- lsp setup
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("bashls", {
      capabilities = capabilities,
    })

    vim.lsp.enable("bashls")
  end,
},

    'dracula/vim',
    'vim-airline/vim-airline',
    'vim-airline/vim-airline-themes'

}
