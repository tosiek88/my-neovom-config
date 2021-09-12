local packer = require("packer")
local use = packer.use
local lualine_config = require("lualine-config")

return packer.startup(
    function()
        use "wbthomason/packer.nvim"
        use "f-person/git-blame.nvim"
        use {
          "blackCauldron7/surround.nvim",
          config = function()
            require"surround".setup {mappings_style = "surround"}
          end
        }
        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true},
            config = function()
                require("lualine").setup(lualine_config)
            end
        }
        use {
            "folke/tokyonight.nvim",
            config = function()
            end
        }
        use {
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup {}
            end
        }

        -- language related plugins
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require("treesitter-nvim").config()
            end
        }
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup {}
            end
        }
        use 'glepnir/lspsaga.nvim'
        use {
            "TimUntersberger/neogit",
            requires = "nvim-lua/plenary.nvim"
        }

        use {
            "neovim/nvim-lspconfig",
            event = "BufRead",
            config = function()
                require("nvim-lspconfig").config()
            end
        }

        use {
            "mhartington/formatter.nvim",
            config = function()
                require("formatter").setup(
                    {
                        logging = false,
                        filetype = {
                            javascript = {
                                function()
                                    return {
                                        exe = "eslint_d",
                                        args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
                                        stdin = true
                                    }
                                end
                            },
                            vue = {
                                -- prettier
                                function()
                                    return {
                                        exe = "eslint_d",
                                        args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
                                        stdin = true
                                    }
                                end
                            },
                            typescript = {
                                -- prettier
                                function()
                                    return {
                                        exe = "prettier",
                                        args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
                                        stdin = true
                                    }
                                end
                            },
                            lua = {
                                -- luafmt
                                function()
                                    return {
                                        exe = "luafmt",
                                        args = {"--indent-count", 2, "--stdin"},
                                        stdin = true
                                    }
                                end
                            }
                        }
                    }
                )
            end
        }

        use "kabouzeid/nvim-lspinstall"
        use {
            "NTBBloodbath/rest.nvim",
            requires = {"nvim-lua/plenary.nvim"},
            config = function()
                require("rest-nvim").setup()
            end,
            event = "BufEnter"
        }

        use {
            "onsails/lspkind-nvim",
            event = "BufRead",
            config = function()
                require("lspkind").init()
            end
        }
        -- load compe in insert mode only
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("compe-completion").config()
            end,
            wants = {"LuaSnip"},
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    event = "InsertCharPre",
                    config = function()
                        require("compe-completion").snippets()
                    end
                },
                "rafamadriz/friendly-snippets"
            }
        }

        use {
            "sbdchd/neoformat",
            cmd = "Neoformat"
        }

        use {
            "phaazon/hop.nvim",
            as = "hop",
            config = function()
                -- you can configure Hop the way you like here; see :h hop-config
                require "hop".setup {keys = "etovxqpdygfblzhckisuran"}
            end
        }
        use "kyazdani42/nvim-web-devicons"
        use "ms-jpq/chadtree"
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
                {"nvim-telescope/telescope-media-files.nvim"},
                {"nvim-telescope/telescope-project.nvim"}
            },
            cmd = "Telescope",
            config = function()
                require("telescope-nvim").config()
            end
        }
        -- misc plugins
        use {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function()
                require("nvim-autopairs").setup()
            end
        }

        use {
            "andymass/vim-matchup",
            event = "CursorMoved"
        }

        use {
            "terrortylor/nvim-comment",
            cmd = "CommentToggle",
            config = function()
                require("nvim_comment").setup()
            end
        }

        use {
            "glepnir/dashboard-nvim",
            cmd = {
                "Dashboard",
                "DashboardNewFile",
                "DashboardJumpMarks"
            },
            setup = function()
                require("dashboard").config()
            end
        }

        use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}

        -- load autosave only if its globally enabled
        use {
            "907th/vim-auto-save",
            cond = function()
                return vim.g.auto_save == 1
            end
        }

        -- smooth scroll
        use {
            "karb94/neoscroll.nvim",
            event = "WinScrolled",
            config = function()
                require("neoscroll").setup()
            end
        }
    end,
    {
        display = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
        }
    }
)
