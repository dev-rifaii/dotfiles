vim.api.nvim_set_option_value("clipboard", "unnamedplus", {})
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 4   -- Number of spaces inserted when indenting
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.wo.wrap = false

local C_LSP_BIN_PATH
local LUA_LSP_BIN_PATH=vim.fn.expand('$HOME/tools/lua-language-server/bin/lua-language-server')

local function auto_complete(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
        return { abbr = item.label:gsub('%b()', '') }
    end,
    })
end

--vim.cmd[[set completeopt+=menuone,noselect,popup]]
if C_LSP_BIN_PATH or vim.fn.executable("ccls") == 1 then
    vim.lsp.config['c_lsp'] = {
        cmd = { 'ccls' },
        filetypes = { 'c' },
        root_markers = { 'Makefile' },
        on_attach = auto_complete
    }

    vim.lsp.enable('c_lsp')
end

if LUA_LSP_BIN_PATH or vim.fn.executable("lua_language_server") == 1 then
    local cmd = LUA_LSP_BIN_PATH or "lua_language_server"
    vim.lsp.config['lua_lsp'] = {
        cmd = { cmd },
        filetypes = { 'lua' },
        root_markers = { '.git' },
        on_attach = auto_complete,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                }
            }
        }
    }

    vim.lsp.enable('lua_lsp')
end


vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
        vim.keymap.set('i', '<c-space>', function()
          vim.lsp.completion.get()
        end)
    end,
})
