return {
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup()
    end
  },
  {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup()
    end
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  },
  {
    'ibhagwan/fzf-lua',
    config = function()
      require('fzf-lua').setup()
    end,
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
      },
      {
        '<leader>rg',
        function()
          require('fzf-lua').grep_project()
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
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        ruby = {'rubocop'}
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
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
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
  },
  {
    'nvim-neotest/neotest',
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-rspec')
        }
      })
    end,
    dependencies = {
      'antoinemadec/FixCursorHold.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'olimorris/neotest-rspec'
    },
    keys = {
      {
        '<leader>rt',
        function()
          require('neotest').run.run(vim.fn.expand('%'))
        end
      },
      {
        '<leader>rT',
        function()
          require('neotest').run.run()
        end
      }
    }
  },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    keys = {
      {
        '<leader>t',
        '<cmd>NvimTreeToggle<cr>'
      }
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'javascript', 'lua', 'ruby', 'sql', 'vim' },
        highlight = {
          enable = true
        }
      }
    end
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
        '<cmd>Git<cr>'
      },
    },
    lazy = false
  }
}
