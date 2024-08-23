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
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        },
        config = function()
            -- Setup Mason and Mason LSP Config
            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "clangd",    -- C, C++
                    "jsonls",    -- JSON
                    "lua_ls",    -- Lua
                    "pyright",   -- Python
                    "tsserver",  -- TypeScript, JavaScript
                },
            }

            -- LSP Setup with capabilities
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- LSP servers setup
            local lspconfig = require("lspconfig")
            local servers = { "clangd", "jsonls", "lua_ls", "pyright", "tsserver" }

            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {
                    capabilities = capabilities,
                }
            end

            -- UI enhancements for LSP
            require("fidget").setup()

            -- nvim-cmp setup for autocompletion
            local cmp = require("cmp")
            cmp.setup {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                    { name = 'path' },
                })
            }
        end,
    },
}

