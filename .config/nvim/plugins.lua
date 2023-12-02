local auto_dark_mode = require('auto-dark-mode')
auto_dark_mode.setup({
	update_interval = 5000,
	set_dark_mode = function()
		vim.api.nvim_set_option('background', 'dark')
	end,
	set_light_mode = function()
		vim.api.nvim_set_option('background', 'light')
	end,
})
auto_dark_mode.disable()
vim.keymap.set('n', '<leader>ec',
	function()
		print('test')
		auto_dark_mode.check_is_dark_mode(
				auto_dark_mode.change_theme_if_needed)
	end
)

