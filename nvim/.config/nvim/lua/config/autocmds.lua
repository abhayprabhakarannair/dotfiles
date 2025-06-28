-- Run lint on these scenarios
local lint_helper_biome = require("utils.lint_helper_biome")
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
	group = lint_augroup,
	callback = function()
		local ft = vim.bo.filetype

		local skip_filetypes = {
			"TelescopePrompt",
			"neo-tree",
			"dashboard",
			"log",
			"fugitive",
			"gitcommit",
			"txt",
			"help",
		}

		if not vim.tbl_contains(skip_filetypes, ft) then
			require("lint").try_lint()
		end
	end,
})

-- Dynamic Linter Selection Autocmd
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = lint_augroup,
	callback = function(args)
		lint_helper_biome.select_biome_linters(args.buf)
	end,
})

-- Confiure lsp settings after its attached to buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		-- Helper function to help in mapping LSP commands
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local fzf = require("fzf-lua")

		-- Go to definition of the word under the cursor, <C-t> to go back
		map("gd", fzf.lsp_definitions, "[G]oto [D]efinition")

		-- Find references for the word under the cursor.
		map("gr", fzf.lsp_references, "[G]oto [R]eferences")

		-- Go to implementations of the word under the cursor, Something like types / interfaces
		map("gI", fzf.lsp_implementations, "[G]oto [I]mplementation")

		-- Go to teh definition of its type, not where its defined, helps more in seeing built-in / library types.
		map("<leader>D", fzf.lsp_typedefs, "Type [D]efinition")

		-- Find all the symbols in the current document, like variables, functions, types, etc.
		map("<leader>ds", fzf.lsp_document_symbols, "[D]ocument [S]ymbols")

		-- Find all the symbols in the current workspace, like document symbols, but project wide.
		map("<leader>ws", fzf.lsp_workspace_symbols, "[W]orkspace [S]ymbols")

		-- Rename the variable under the cursor across files.
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Execute a code action for the word / error under the cursor, like import helps
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

		-- Go to declaration (Different from 'go to definition'), ex: in C this would take to the header.
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Temporary check for unsupported versions (Can remove in future)
		local function client_supports_method(client, method, bufnr)
			if vim.fn.has("nvim-0.11") == 1 then
				return client:supports_method(method, bufnr)
			else
				return client.supports_method(method, { bufnr = bufnr })
			end
		end

		-- Cursor idle actions
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if
			client
			and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
		then
			local highlight_augroup = vim.api.nvim_create_augroup("config-lsp-highlight", { clear = false })

			-- Highlight all the references of the word under the curson on idle.
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			-- Remove hightlighted references on cursor move.
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			-- Remove hightlighted references on lsp detach as well.
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("config-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "config-lsp-highlight", buffer = event2.buf })
				end,
			})
		end
	end,
})
