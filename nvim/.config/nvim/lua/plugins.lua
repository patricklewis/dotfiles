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
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip'
    },
    config = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      local cmp = require('cmp')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local lspkind = require('lspkind')

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            symbol_map = { Copilot = "" },
            ellipsis_char = '...',
            before = function(entry, vim_item)
              return vim_item
            end
          })
        },
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'vsnip' }
        }, {
          { name = 'buffer' }
        })
      })

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig')['solargraph'].setup {
        capabilities = capabilities
      }

      require'lspconfig'.eslint.setup{}
      require'lspconfig'.flow.setup{}
    end
  },
  {
    'ibhagwan/fzf-lua',
    config = function()
      require('fzf-lua').setup({
        keymap= {
          fzf = {
            ['CTRL-Q'] = 'select-all+accept'
          }
        }
      })
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
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').solargraph.setup{}
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
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
        },
        output = {
          enabled = true,
          open_on_run = true
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
        '<leader>ro',
        function()
          require('neotest').output.open()
        end
      },
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
        endwise = {
          enable = true
        },
        ensure_installed = { 'fish', 'javascript', 'lua', 'ruby', 'sql', 'vim' },
        indent = {
          enable = true
        },
        highlight = {
          enable = true
        }
      }
    end,
    dependencies = {
      'RRethy/nvim-treesitter-endwise'
    }
  },
  {
    'onsails/lspkind.nvim'
  },
  {
    'rbong/vim-flog',
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
  },
  {
    'tpope/vim-rails'
  },
  {
    'tpope/vim-unimpaired'
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        copilot_node_command = vim.fn.expand("$HOME") .. '/.nodenv/versions/18.15.0/bin/node',
        panel = { enabled = false },
        suggestion = { enabled = false }
      })
    end
  },
  {
    'zbirenbaum/copilot-cmp',
    after = { 'copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end
  }
}
