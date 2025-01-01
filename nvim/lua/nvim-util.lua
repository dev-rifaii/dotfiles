--function Get_visual_selection()
--    -- Get the current buffer
--    local bufnr = vim.api.nvim_get_current_buf()
--
--    -- Get the start and end positions of the visual selection
--    local _, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
--    local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))
--
--    -- Adjust for 0-based indexing
--    start_line = start_line - 1
--    end_line = end_line - 1
--
--    -- Fetch the lines
--    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)
--    print(lines)
--    print(#lines)
--    for key, value in pairs(lines) do
--       print(key, value)
--    end
--
--    -- Handle single-line selection by slicing the text
--    if #lines == 1 then
--        lines[1] = string.sub(lines[1], start_col + 1, end_col)
--    else
--        -- Adjust the first and last lines for multi-line selections
--        lines[1] = string.sub(lines[1], start_col + 1)
--        lines[#lines] = string.sub(lines[#lines], 1, end_col)
--    end
--
--    return lines
--end
--
--return {
--    Get_visual_selection
--}
--
--

function Get_visual_selection()
    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- Get the start and end positions of the visual selection
    local pos_start = vim.fn.getpos("'<")
    local pos_end = vim.fn.getpos("'>")

    for key, value in pairs(pos_start) do
        print(key, value)
    end

    print('--------')
    for key, value in pairs(pos_end) do
        print(key, value)
    end

    return {}
end

return {
    Get_visual_selection
}
