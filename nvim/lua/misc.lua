require"nvim-util"

local comment_chars = {
    ["lua"] = "--",
    ["java"] = "//",
    ["sql"] = "--",
    ["swift"] = "//",
}

local function is_line_commented(line, comment_str)
    local stripped_line = string.gsub(line, "%s+", "")
    return comment_str == string.sub(stripped_line, 1, #comment_str)
end

local function toggle_comment(line)
    local file_extension = vim.fn.expand("%:e")
    local file_comment_str = comment_chars[file_extension]

    if file_comment_str == nil then
        print("Commenting not supported for file type " .. file_extension)
        return
    end

    if (is_line_commented(line, file_comment_str)) then
        vim.cmd(string.format("normal! ^%ddl", #file_comment_str))
        return
    end

    vim.cmd(string.format("normal! ^i%s", file_comment_str))
end


local function comment()
    local mode = vim.fn.mode()
    if "n" == mode then
        toggle_comment(vim.api.nvim_get_current_line())
    end
    if "v" == mode then
        for key, value in pairs(Get_visual_selection()) do
           print(key, value)
        end
    end

end

-- Set up the keymap for Left Ctrl + /
vim.keymap.set({ "n", "v" }, "<C-/>", comment, { noremap = true, silent = true })

--auto formatting
function Format_current_buffer()
    vim.lsp.buf.format({ async = true })
end

vim.api.nvim_set_keymap(
    "n",                                -- Normal mode
    "<C-A-l>",                          -- Key combination: Ctrl + Alt + L
    ":lua Format_current_buffer()<CR>", -- Command to execute
    { noremap = true, silent = true }   -- Options: No recursive mapping, silent execution
)

--terminal
vim.keymap.set("n", "<C-s>t", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 8)
end)

vim.api.nvim_set_keymap('t', '<C-s>', [[<C-\><C-n>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Tab>', '<Tab>', { noremap = true, silent = true })
