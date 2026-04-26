vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- options
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

-- disable netrw (using nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- word wrap navigation
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic' })

vim.keymap.set('i', 'jk', '<Esc>', {})

-- move lines in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- keep cursor centered
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- copy to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set('n', 'YY', 'va{Vy')

vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format buffer' })

vim.keymap.set('n', '<Space>h', ':noh<cr>')
vim.keymap.set('n', 'ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>cd', [[:let @+ = expand('%')<CR>]])

-- keep visual mode when indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', '<leader>ng', ':Neogit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>z', ':ZenMode<CR>', { noremap = true, silent = true })

-- quickfix navigation
vim.keymap.set('n', "<leaderql'", '<cmd>cnext<CR>zz', { desc = 'Forward qfixlist' })
-- vim.keymap.set('n', '<leader>l,', '<cmd>cprev<CR>zz', { desc = 'Backward qfixlist' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.g.gruvbox_material_transparent_background = true

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require('lazy').setup({
  'tpope/vim-sleuth',

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
      },
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        view = { adaptive_size = true },
        git = { ignore = false },
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
      }
      vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>ss', builtin.lsp_workspace_symbols, { desc = 'Search workspace Symbols' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search current Word' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search Resume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = 'Search in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search Neovim files' })

      vim.keymap.set('n', '<leader>gc', builtin.git_status, { desc = 'Git Changes' })
    end,
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'love2d.nvim/love2d/library', words = { 'love' } },
      },
    },
  },

  { 'Bilal2453/luvit-meta', lazy = true },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          registries = {
            'github:mason-org/mason-registry',
            'github:Crashdummyy/mason-registry',
          },
        },
      },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- register pico8-ls (not in lspconfig's built-in server list)
      -- local configs = require 'lspconfig.configs'
      -- if not configs.pico8_ls then
      --   configs.pico8_ls = {
      --     default_config = {
      --       cmd = { 'pico8-ls', '--stdio' },
      --       filetypes = { 'pico8', 'p8' },
      --       root_dir = function(fname)
      --         return vim.fs.dirname(fname)
      --       end,
      --       settings = {},
      --     },
      --   }
      -- end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
          map('gr', require('telescope.builtin').lsp_references, 'Goto References')
          map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
          map('<leader>rn', vim.lsp.buf.rename, 'Rename')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay Hints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        gopls = {},
        zls = {},
        rust_analyzer = {},
        tsserver = {},
        clangd = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = 'space',
                  indent_size = '2',
                },
              },
            },
          },
        },
        ols = {},
        pico8_ls = {},
      }

      require('mason').setup {
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry',
        },
      }
      require('mason-tool-installer').setup {
        ensure_installed = {
          'lua-language-server',
          'typescript-language-server',
          'gopls',
          'rust-analyzer',
          'clangd',
          'stylua',
          'ols',
          'roslyn',
        },
      }

      -- for server_name, server_config in pairs(servers) do
      --   local server = server_config or {}
      --   server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      --   require('lspconfig')[server_name].setup(server)
      -- end

      for server_name, server_config in pairs(servers) do
        local server = server_config or {}

        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

        vim.lsp.config(server_name, server)
        vim.lsp.enable(server_name)
      end
    end,
  },

  {
    'seblyng/roslyn.nvim',
    ft = 'cs',
    opts = {
      broad_search = true,
    },
    config = function(_, opts)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      vim.lsp.config('roslyn', {
        capabilities = capabilities,
        settings = {
          ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_parameters = true,
          },
          ['csharp|completion'] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
          },
        },
      })

      require('roslyn').setup(opts)
    end,
  },

  -- using lazy.nvim
  -- {
  --   'S1M0N38/love2d.nvim',
  --   event = 'VeryLazy',
  --   version = '2.*',
  --   opts = {},
  --   keys = {
  --     { '<leader>l', ft = 'lua', desc = 'LÖVE' },
  --     { '<leader>lr', '<cmd>LoveRun<cr>', ft = 'lua', desc = 'Run LÖVE' },
  --     { '<leader>ls', '<cmd>LoveStop<cr>', ft = 'lua', desc = 'Stop LÖVE' },
  --   },
  -- },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_after_save = function(bufnr)
        local disable_filetypes = { c = false, cpp = true }
        local lsp_format_opt = disable_filetypes[vim.bo[bufnr].filetype] and 'never' or 'fallback'
        return { timeout_ms = 2000, lsp_format = lsp_format_opt }
      end,
      formatters = {
        ['clang-format'] = {
          prepend_args = { '--style={IndentWidth: 4, TabWidth: 4, UseTab: Never}' },
        },
        eslint_d = {
          condition = function(ctx)
            local root = vim.fs.dirname(vim.fs.find({
              '.eslintrc',
              '.eslintrc.js',
              '.eslintrc.cjs',
              '.eslintrc.mjs',
              '.eslintrc.json',
              '.eslintrc.yaml',
              '.eslintrc.yml',
              'eslint.config.js',
              'eslint.config.cjs',
              'eslint.config.mjs',
              'eslint.config.ts',
            }, { path = ctx.filename, upward = true })[1] or '')
            return root ~= nil and root ~= ''
          end,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        javascript = { 'prettierd', 'eslint_d', stop_after_first = true },
        typescript = { 'prettierd', 'eslint_d', stop_after_first = true },
        javascriptreact = { 'prettierd', 'eslint_d', stop_after_first = true },
        typescriptreact = { 'prettierd', 'eslint_d', stop_after_first = true },
        elixir = { 'mix_format' },
        exs = { 'mix_format' },
        odin = { 'odinfmt' },
      },
    },
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'lazydev', group_index = 0 },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      local cache_dir = vim.fn.stdpath 'cache'
      local bg_file = cache_dir .. '/background_setting.txt'
      local contrast_file = cache_dir .. '/contrast_setting.txt'

      local function read_background_setting()
        local f = io.open(bg_file, 'r')
        if f then
          local bg = f:read '*l'
          f:close()
          if bg == 'light' or bg == 'dark' then
            return bg
          end
        end
        return 'dark'
      end

      local function save_background_setting(bg)
        local f = io.open(bg_file, 'w')
        if f then
          f:write(bg)
          f:close()
        else
          vim.notify('Error: Could not write background setting to file', vim.log.levels.ERROR)
        end
      end

      local function read_contrast_setting()
        local f = io.open(contrast_file, 'r')
        if f then
          local contrast = f:read '*l'
          f:close()
          if contrast == 'hard' or contrast == 'medium' or contrast == 'soft' then
            return contrast
          end
        end
        return 'hard'
      end

      local function save_contrast_setting(contrast)
        local f = io.open(contrast_file, 'w')
        if f then
          f:write(contrast)
          f:close()
        else
          vim.notify('Error: Could not write contrast setting to file', vim.log.levels.ERROR)
        end
      end

      vim.o.background = read_background_setting()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = read_contrast_setting()
      vim.cmd.colorscheme 'gruvbox-material'

      local function index_of(tbl, val)
        for i, v in ipairs(tbl) do
          if v == val then
            return i
          end
        end
        return nil
      end

      function ToggleBackground()
        if vim.o.background == 'dark' then
          vim.o.background = 'light'
        else
          vim.o.background = 'dark'
        end
        save_background_setting(vim.o.background)
        vim.cmd.colorscheme 'gruvbox-material'
      end

      function ToggleContrast()
        local contrasts = { 'hard', 'medium', 'soft' }
        local current_contrast = vim.g.gruvbox_material_background
        local idx = index_of(contrasts, current_contrast) or 1
        local next_idx = (idx % #contrasts) + 1
        local new_contrast = contrasts[next_idx]
        vim.g.gruvbox_material_background = new_contrast
        save_contrast_setting(new_contrast)
        vim.cmd.colorscheme 'gruvbox-material'
        print('Contrast set to ' .. new_contrast)
      end

      vim.keymap.set('n', '<leader>bg', ToggleBackground, { desc = 'Toggle background' })
      vim.keymap.set('n', '<leader>bc', ToggleContrast, { desc = 'Toggle contrast' })
    end,
  },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- {
  --   'echasnovski/mini.nvim',
  --   config = function()
  --     require('mini.surround').setup()
  --     local statusline = require 'mini.statusline'
  --     statusline.setup { use_icons = vim.g.have_nerd_font }
  --     statusline.section_location = function()
  --       return '%2l:%-2v'
  --     end
  --   end,
  -- },

  {
    'romus204/tree-sitter-manager.nvim',
    dependencies = {}, -- tree-sitter CLI must be installed system-wide
    config = function()
      require('tree-sitter-manager').setup {
        -- Default Options
        -- ensure_installed = {}, -- list of parsers to install at the start of a neovim session
        -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
        -- auto_install = false, -- if enabled, install missing parsers when editing a new file
        -- highlight = true, -- treesitter highlighting is enabled by default
        -- languages = {}, -- override or add new parser sources
        -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
        -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
      }
    end,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      dapui.setup()

      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
          args = { '--port', '${port}' },
        },
      }

      dap.configurations.c = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      dap.configurations.odin = {
        {
          name = 'Odin: Debug (build + launch)',
          type = 'codelldb',
          request = 'launch',
          program = function()
            -- build first
            vim.notify('Building Odin (debug)...', vim.log.levels.INFO)
            local out = vim.fn.system { 'sh', '-lc', './scripts/build_debug.sh' }
            if vim.v.shell_error ~= 0 then
              vim.notify(out, vim.log.levels.ERROR)
              error 'Odin debug build failed'
            end
            -- then debug-launch the binary (NOT the script)
            return vim.fn.getcwd() .. '/bin/debug/game'
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {}, -- add args here if needed
        },

        {
          name = 'Odin: Release (build + launch)',
          type = 'codelldb',
          request = 'launch',
          program = function()
            vim.notify('Building Odin (release)...', vim.log.levels.INFO)
            local out = vim.fn.system { 'sh', '-lc', './scripts/build_release.sh' }
            if vim.v.shell_error ~= 0 then
              vim.notify(out, vim.log.levels.ERROR)
              error 'Odin release build failed'
            end
            return vim.fn.getcwd() .. '/bin/release/fae'
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      local lldebugger_path = vim.fn.stdpath 'data' .. '/mason/packages/local-lua-debugger-vscode'

      dap.adapters['lua-local'] = {
        type = 'executable',
        command = 'node',
        args = { lldebugger_path .. '/extension/extension/debugAdapter.js' },
        enrich_config = function(config, on_config)
          config = vim.deepcopy(config)
          if not config.extensionPath then
            config.extensionPath = lldebugger_path .. '/extension/extension/'
          end
          on_config(config)
        end,
      }

      dap.configurations.lua = {
        {
          name = 'LÖVE: Debug',
          type = 'lua-local',
          request = 'launch',
          program = { command = '/Applications/love.app/Contents/MacOS/love' },
          args = { '.', 'debug' },
        },
        {
          name = 'LÖVE: Release',
          type = 'lua-local',
          request = 'launch',
          program = { command = '/Applications/love.app/Contents/MacOS/love' },
          args = { '.' },
        },
      }

      dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.stdpath 'data' .. '/mason/bin/netcoredbg',
        args = { '--interpreter=vscode' },
      }

      -- Shared state for the selected .NET project so program/cwd stay in sync
      local _dotnet_dll = nil
      local _dotnet_cwd = nil

      local function resolve_dotnet_project()
        local cwd = vim.fn.getcwd()
        local handle = io.popen('find "' .. cwd .. '" -name "*.csproj" -not -path "*/obj/*" 2>/dev/null')
        if not handle then
          return nil
        end
        local result = handle:read '*a'
        handle:close()

        local projects = {}
        for line in result:gmatch '[^\n]+' do
          local f = io.open(line, 'r')
          if f then
            local content = f:read '*a'
            f:close()
            -- Must have WinExe/Exe output AND reference a MonoGame or Microsoft.NET.Sdk framework
            -- (filters out content pipeline tools and class libraries)
            if
              (content:match '<OutputType>WinExe</OutputType>' or content:match '<OutputType>Exe</OutputType>')
              and not content:match 'MonoGame%.Framework%.Content%.Pipeline'
            then
              table.insert(projects, line)
            end
          end
        end

        if #projects == 0 then
          return nil
        end

        local selected
        if #projects == 1 then
          selected = projects[1]
        else
          local choices = {}
          for i, p in ipairs(projects) do
            choices[i] = p:gsub(cwd .. '/', '')
          end
          local idx = vim.fn.inputlist(vim.list_extend(
            { 'Select project:' },
            vim.tbl_map(function(c)
              return (' %d. %s'):format(vim.fn.index(choices, c) + 1, c)
            end, choices)
          ))
          if idx < 1 or idx > #projects then
            return nil
          end
          selected = projects[idx]
        end

        local f = io.open(selected, 'r')
        if not f then
          return nil
        end
        local content = f:read '*a'
        f:close()

        local tfm = content:match '<TargetFramework>(.-)</TargetFramework>'
        local asm_name = content:match '<AssemblyName>(.-)</AssemblyName>'
        if not asm_name then
          asm_name = vim.fn.fnamemodify(selected, ':t:r')
        end

        local proj_dir = vim.fn.fnamemodify(selected, ':h')
        local out_dir = proj_dir .. '/bin/Debug/' .. (tfm or 'net9.0')
        local dll_path = out_dir .. '/' .. asm_name .. '.dll'

        -- Always rebuild to pick up latest changes
        vim.notify('Building ' .. vim.fn.fnamemodify(selected, ':t') .. '...', vim.log.levels.INFO)
        vim.fn.system('dotnet build "' .. selected .. '" -c Debug')

        _dotnet_dll = dll_path
        _dotnet_cwd = out_dir
        return dll_path
      end

      dap.configurations.cs = {
        {
          name = 'Launch .NET Project',
          type = 'coreclr',
          request = 'launch',
          program = function()
            local dll = resolve_dotnet_project()
            if not dll then
              return vim.fn.input('Path to DLL: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            end
            return dll
          end,
          cwd = function()
            return _dotnet_cwd or vim.fn.getcwd()
          end,
        },
      }

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end

      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Continue' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Debug: Open REPL' })
      vim.keymap.set('n', '<leader>dk', function()
        require('dapui').eval(nil, { enter = true })
      end, { desc = 'Debug: Inspect under cursor' })
      vim.keymap.set('n', '<F13>', dap.restart, { desc = 'Debug: Restart' })
      vim.keymap.set('n', '<leader>de', dap.terminate, { desc = 'Debug: End' })
    end,
  },

  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      vim.keymap.set('n', '<leader>ho', require('harpoon.ui').toggle_quick_menu, { desc = 'Harpoon Open' })
      vim.keymap.set('n', '<leader>ha', require('harpoon.mark').add_file, { desc = 'Harpoon Mark' })
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = true,
  },

  {
    'folke/zen-mode.nvim',
    opts = { window = { width = 0.5 } },
  },

  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    opts = {
      preview = {
        filetypes = { 'markdown' },
        ignore_buftypes = {},
      },
    },
  },

  {
    'echasnovski/mini.diff',
    config = function()
      local diff = require 'mini.diff'
      diff.setup { source = diff.gen_source.none() }
    end,
  },

  { 'HakonHarnes/img-clip.nvim', opts = {} },

  { 'akinsho/toggleterm.nvim', version = '*', opts = {} },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
