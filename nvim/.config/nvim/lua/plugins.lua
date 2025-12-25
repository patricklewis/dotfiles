return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'latte',
        background = {
          light = 'latte',
          dark = 'latte',
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
        }
      })

      vim.o.background = 'light'
      vim.cmd.colorscheme 'catppuccin'
    end
  },
  {
    'dense-analysis/ale',
    config = function()
      vim.g.ale_disable_lsp = 1
      vim.g.ale_linters = {
        ruby = {'rubocop', 'ruby'}
      }
    end
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
    'https://codeberg.org/andyg/leap.nvim',
    dependencies = {
      'tpope/vim-repeat'
    },
    config = function()
      vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
      vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')

      -- Highly recommended: define a preview filter to reduce visual noise
      -- and the blinking effect after the first keypress
      -- (`:h leap.opts.preview`). You can still target any visible
      -- positions if needed, but you can define what is considered an
      -- exceptional case.
      -- Exclude whitespace and the middle of alphabetic words from preview:
      --   foobar[baaz] = quux
      --   ^----^^^--^^-^-^--^
      require('leap').opts.preview = function (ch0, ch1, ch2)
        return not (
          ch1:match('%s')
          or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
        )
      end

      -- Define equivalence classes for brackets and quotes, in addition to
      -- the default whitespace group:
      require('leap').opts.equivalence_classes = {
        ' \t\r\n', '([{', ')]}', '\'"`'
      }

      -- Use the traversal keys to repeat the previous motion without
      -- explicitly invoking Leap:
      require('leap.user').set_repeat_keys('<enter>', '<backspace>')
    end
  },
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
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
      local cmp = require('cmp')

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'vsnip', group_index = 2 }
        }, {
          { name = 'buffer' }
        }),
        window = {
          completion = { border = 'single' },
          documentation = { border = 'single' }
        }
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.config('bashls', {
        capabilities = capabilities
      })

      vim.lsp.config('eslint', {
        capabilities = capabilities
      })

      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {'vim'}
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false
            },
            telemetry = {
              enable = false
            }
          }
        }
      })

      vim.lsp.config('ruby_lsp', {
        capabilities = capabilities,
        init_options = {
          enabledFeatures = {
            diagnostics = false,
            formatting = false
          }
        }
      })

      vim.lsp.config('yamlls', {
        capabilities = capabilities
      })
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
      require('gitsigns').setup{
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
          map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line{full=true} end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
    end
  },
  {
    'neovim/nvim-lspconfig'
  },
  {
    'ntpeters/vim-better-whitespace'
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
        extensions = {
          'fugitive',
          'fzf',
          'lazy',
          'nvim-tree',
          'quickfix',
          'trouble'
        },
        options = {
          theme = 'catppuccin'
        },
        tabline = {
          lualine_a = {'buffers'},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {'tabs'}
        }
      }
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
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
        ensure_installed = {
          'fish',
          'javascript',
          'json',
          'jsonc',
          'lua',
          'ruby',
          'sql',
          'vim'
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
    'rbong/vim-flog'
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
      }
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
    'tiagovla/scope.nvim',
    config = function()
      require('scope').setup({})
    end
  },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {},
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} }
    }
  }
}
