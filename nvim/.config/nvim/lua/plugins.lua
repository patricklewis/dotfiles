return {
	{
		'ggandor/leap.nvim',
		config = function()
			require('leap').add_default_mappings()
		end
	},
  {
    'ibhagwan/fzf-lua',
    keys = {
      {
        '<leader>ff',
        function()
          require('fzf-lua').files()
        end
      },
      {
        '<leader>fb',
        function()
          require('fzf-lua').buffers()
        end
      }
    }
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
	{
		'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
		config = function()
			vim.cmd[[colorscheme dracula]]
		end
	},
  {
    'ntpeters/vim-better-whitespace'
  },
	{
		'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'dracula'
        }
      }
    end
	},
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
    end,
    keys = {
      {
        '<leader>t',
        '<cmd>NvimTreeToggle<cr>'
      }
    }
  },
	{
		'nvim-tree/nvim-web-devicons'
	},
	{
		'tpope/vim-fugitive',
    keys = {
      {
        '<leader>gc',
        '<cmd>Git commit<cr>'
      },
      {
        '<leader>gd',
        '<cmd>Git diff --cached<cr>'
      },
      {
        '<leader>gs',
        '<cmd>Git status<cr>'
      }
    }
	}
}
