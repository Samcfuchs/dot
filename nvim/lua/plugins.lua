return {

	{
		"ahmedkhalf/project.nvim",
		lazy = false,
		config = function()
			require("project_nvim").setup({})
		end,
		--opts = { detection_methods = { "lsp", "pattern" }, },
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		--branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		config = function()
			require("neo-tree").setup({
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_ignored = false,
					},
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},

		config = function()
			-- mason
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"pyright",
					"ruff",
					"ts_ls",
					"eslint",
					"html",
					"cssls",
					"jsonls",
					"tailwindcss",
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = { "prettier", "ruff" },
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

			local servers = {
				"bashls",
				"pyright",
				"ruff",
				"ts_ls",
				"eslint",
				"html",
				"cssls",
				"jsonls",
				"tailwindcss",
			}
			for _, server in ipairs(servers) do
				vim.lsp.config(server, { capabilities = capabilities })
				vim.lsp.enable(server)
			end

			-- disable ruff hover in favour of pyright
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "ruff" then
						client.server_capabilities.hoverProvider = false
					end
				end,
			})
		end,
	},

	{ "dracula/vim" },
	{ "folke/flash.nvim" },
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					python = { "ruff_format", "ruff_organize_imports" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					lua = { "stylua" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				require("conform").format({ async = true })
			end, { desc = "[F]ormat buffer" })
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
		--config = function() end,
	},

	{
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "dracula",
				powerline_fonts = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			tabline = {
				lualine_a = { "buffers" },
				lualine_z = { "tabs" },
			},
		},
	},

	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		---@module 'gitsigns'
		---@diagnostic disable-next-line: missing-fields
		opts = {
			signs = {
				add = { text = "+" }, ---@diagnostic disable-line: missing-fields
				change = { text = "~" }, ---@diagnostic disable-line: missing-fields
				delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
				topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
				changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
			},
		},
	},

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter",
		---@module 'which-key'
		---@diagnostic disable-next-line: missing-fields
		opts = {
			-- delay between pressing a key and opening which-key (milliseconds)
			delay = 500,
			icons = { mappings = vim.g.have_nerd_font },

			-- Document existing key chains
			spec = {
				{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } }, -- Enable gitsigns recommended keymaps first
				{ "gr", group = "LSP Actions", mode = { "n" } },
			},
		},
	},

	-- NOTE this should be highlighted
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		---@module 'todo-comments'
		---@diagnostic disable-next-line: missing-fields
		opts = { signs = false },
	},

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		enabled = true,
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			{ "JoseConseco/telescope_sessions_picker.nvim" },
		},
		config = function()
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				pickers = {
					find_files = { theme = "dropdown" },
				},
				extensions = {
					["ui-select"] = { require("telescope.themes").get_dropdown() },
					sessions_picker = { sessions_dir = "/home/sam/.local/state/nvim/sessions" },
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "projects")
			pcall(require("telescope").load_extension, "sessions_picker")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
			-- it is better explained there). This allows easily switching between pickers if you prefer using something else!
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
				callback = function(event)
					local buf = event.buf

					-- Find references for the word under your cursor.
					vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })

					-- Jump to the implementation of the word under your cursor.
					-- Useful when your language has ways of declaring types without an actual implementation.
					vim.keymap.set(
						"n",
						"gri",
						builtin.lsp_implementations,
						{ buffer = buf, desc = "[G]oto [I]mplementation" }
					)

					-- Jump to the definition of the word under your cursor.
					-- This is where a variable was first declared, or where a function is defined, etc.
					-- To jump back, press <C-t>.
					vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })

					-- Fuzzy find all the symbols in your current document.
					-- Symbols are things like variables, functions, types, etc.
					vim.keymap.set(
						"n",
						"gO",
						builtin.lsp_document_symbols,
						{ buffer = buf, desc = "Open Document Symbols" }
					)

					-- Fuzzy find all the symbols in your current workspace.
					-- Similar to document symbols, except searches over your entire project.
					vim.keymap.set(
						"n",
						"gW",
						builtin.lsp_dynamic_workspace_symbols,
						{ buffer = buf, desc = "Open Workspace Symbols" }
					)

					-- Jump to the type of the word under your cursor.
					-- Useful when you're not sure what type a variable is and you want to see
					-- the definition of its *type*, not where it was *defined*.
					vim.keymap.set(
						"n",
						"grt",
						builtin.lsp_type_definitions,
						{ buffer = buf, desc = "[G]oto [T]ype Definition" }
					)
				end,
			})

			-- Override default behavior and theme when searching
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
		config = function()
			-- ensure basic parser are installed
			local parsers = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"python",
				"vim",
				"vimdoc",
			}
			require("nvim-treesitter").install(parsers)

			---@param buf integer
			---@param language string
			local function treesitter_try_attach(buf, language)
				-- check if parser exists and load it
				if not vim.treesitter.language.add(language) then
					return
				end
				-- enables syntax highlighting and other treesitter features
				vim.treesitter.start(buf, language)

				-- enables treesitter based folds
				-- for more info on folds see `:help folds`
				-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
				-- vim.wo.foldmethod = 'expr'

				-- check if treesitter indentation is available for this language, and if so enable it
				-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
				local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

				-- enables treesitter based indentation
				if has_indent_query then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end

			local available_parsers = require("nvim-treesitter").get_available()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					local installed_parsers = require("nvim-treesitter").get_installed("parsers")

					if vim.tbl_contains(installed_parsers, language) then
						-- enable the parser if it is installed
						treesitter_try_attach(buf, language)
					elseif vim.tbl_contains(available_parsers, language) then
						-- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
						require("nvim-treesitter").install(language):await(function()
							treesitter_try_attach(buf, language)
						end)
					else
						-- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
						treesitter_try_attach(buf, language)
					end
				end,
			})
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
		opts = function()
			local logo = [[
         ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
         ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
         ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
         ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
         ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
         ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
    ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"

			local opts = {
				theme = "doom",
				hide = {
					-- this is taken care of by lualine
					-- enabling this messes up the actual laststatus setting after loading a file
					statusline = false,
				},
				config = {
					header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = 'Telescope find_files',                           desc = " Find File",       icon = " ", key = "f" },
          { action = 'Telescope projects',                             desc = " Select Project",  icon = " ", key = "p" },
          { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
        --{ action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files",    icon = " ", key = "r" },
        --{ action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text",       icon = " ", key = "g" },
        --{ action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text",       icon = " ", key = "g" },
          { action = 'cd ~/dot/nvim',                                  desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "r" },
          { action = 'lua require("persistence").select()',            desc = " Select Session",  icon = " ", key = "s" },
        --{ action = "LazyExtras",                                     desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
        },
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return {
							"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
						}
					end,
				},
			}

			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end

			-- open dashboard after closing lazy
			if vim.o.filetype == "lazy" then
				vim.api.nvim_create_autocmd("WinClosed", {
					pattern = tostring(vim.api.nvim_get_current_win()),
					once = true,
					callback = function()
						vim.schedule(function()
							vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
						end)
					end,
				})
			end

			return opts
		end,
	},
}
