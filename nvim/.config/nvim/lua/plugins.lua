return {
	{
		"ggandor/leap.nvim",
		config = function()
			require('leap').add_default_mappings()
		end
	},
	{
		"glepnir/dashboard-nvim",
		event = 'VimEnter',
		config = function()
			require('dashboard').setup {
				-- config
			}
		end,
		dependencies = { { 'nvim-tree/nvim-web-devicons' } }
	},
	{
		"Mofiqul/dracula.nvim",
		config = function()
			vim.cmd[[colorscheme dracula]]
		end
	},
	{
		"nvim-lualine/lualine.nvim"
	}
}
