-- Function to replace ": to " with " => " in PHP files
local function replace_column_to_arrow(line)
    return string.gsub(line, '": ', '" => ')
end

-- Function to replace . with -> outside of comments in PHP files
-- because :
-- - "-" and ">" are too distant in my keyboard, sorry
-- - comming from a background where am confortable with . instead of ->
-- - and finally, because am extremly lazy as a dev, lmao.
local function replace_dot_with_arrow(line)
    -- Replace . with -> in lines that are not comments
    return string.gsub(line, '(%w)%.(%w)', '%1->%2')
end

local function entrypoint()
    -- Save the cursor position
    local save_cursor = vim.fn.getpos(".")
    -- Define a pattern to match comments
    -- In this case related to php (#, /*, //)
    -- (yes php comments can be made by # too, i was surprised).
    local comment_pattern = "^%s*(//|/%*|%*|#*)"

    -- FIXME: EXTREMLY BAD IMPLEM FOR NOW LMAO, will fix/adapt later
    -- Considering using the threesiter API ?
    -- add_dollar_to_variables()

    -- Get all lines in the current opened buffer(well, kind of).
    for line_num, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
        if not string.match(line, comment_pattern) then
            -- Set the modified lines back to the buffer only if there are changes
            -- All methods to process lines from the buffer
            local new_line = replace_column_to_arrow(
                replace_dot_with_arrow(line)
            )
            vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { new_line })
        end
    end

    -- Restore the cursor position
    vim.fn.setpos(".", save_cursor)
end

-- Autocommand group for PHP files
vim.api.nvim_create_augroup("php_mappings", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.php",
    callback = function ()
        entrypoint()
    end,
    group = "php_mappings",
})
