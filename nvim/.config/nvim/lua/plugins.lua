return {
  {
    'folke/noice.nvim',
    config = function()
      require('noice').setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify'
    }
  },
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
        ensure_installed = { 'javascript', 'lua', 'ruby', 'vim' },
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
        '<cmd>Git status<cr>'
      }
    }
  }
}
