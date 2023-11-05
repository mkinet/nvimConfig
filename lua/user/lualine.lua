 local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	colored = true,
	update_in_insert = false,
	always_visible = false,
}

local diff = {
	"diff",
  cond = hide_in_width
}

local mode = {
	"mode",
	fmt = function(str)
		return "   " .. str .. "   "
	end,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}
lualine.setup({
	options = {
		icons_enabled = true,
		theme = "sonokai",
		always_divide_middle = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_a = { mode, "filename" },
		lualine_b = { branch, diff,diagnostics},
		lualine_c = {},
		lualine_x = {},
		lualine_y = { "filetype","fileformat","encoding"},
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
