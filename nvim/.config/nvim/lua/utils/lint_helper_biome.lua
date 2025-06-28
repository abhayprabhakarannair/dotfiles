local M = {}

-- Biome-supported file types (extensible)
M.biome_filetypes = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"css",
	"json",
	"jsonc",
}

-- Function to detect Biome configuration
function M.has_biome_config()
	return vim.fn.filereadable("biome.json") == 1
		or vim.fn.filereadable(".biome.json") == 1
		or vim.fn.filereadable("biome.config.json") == 1
end

-- Dynamic linter selection for Biome-supported files
function M.select_biome_linters(bufnr)
	local lint = require("lint")
	local ft = vim.bo[bufnr].filetype

	-- Check if current filetype is supported by Biome
	local is_biome_filetype = vim.tbl_contains(M.biome_filetypes, ft)

	if is_biome_filetype and M.has_biome_config() then
		lint.linters_by_ft[ft] = { "biomejs" }
	elseif is_biome_filetype then
		-- Fallback linters for specific file types
		local fallback_linters = {
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			css = { "stylelint" },
			json = { "jsonlint" },
			jsonc = { "jsonlint" },
		}

		lint.linters_by_ft[ft] = fallback_linters[ft] or {}
	end
end

-- Method to extend Biome-supported file types
function M.extend_biome_filetypes(new_filetypes)
	for _, ft in ipairs(new_filetypes) do
		if not vim.tbl_contains(M.biome_filetypes, ft) then
			table.insert(M.biome_filetypes, ft)
		end
	end
end

return M
