-- Function to add $ to variables in PHP files
local function add_dollar_to_variables()
    -- Save the cursor position
    local save_cursor = vim.fn.getpos(".")
    -- Define a pattern to match PHP comments
    local comment_pattern = "^%s*(//|/%*|%*)"
    -- Define a pattern to match variables (without leading $)
    local variable_pattern = "%f[%a_][a-zA-Z_][a-zA-Z0-9_]*"

    -- Iterate over each line in the buffer
    for lnum = 1, vim.fn.line("$") do
        local line = vim.fn.getline(lnum)

        -- Check if the line is a comment
        if not string.match(line, comment_pattern) then
            -- Add $ to variables that don't have it
            local new_line = string.gsub(line, variable_pattern, function(var)
                -- Add $ only if the variable doesn't already have it
                if not string.match(var, "^%$") then
                    return "$" .. var
                else
                    return var
                end
            end)
            vim.fn.setline(lnum, new_line)
        end
    end

    -- Restore the cursor position
    vim.fn.setpos(".", save_cursor)
end

-- Function to replace . with -> outside of comments in PHP files
local function replace_dot_with_arrow()
    -- Save the cursor position
    local save_cursor = vim.fn.getpos(".")

    -- Define a pattern to match PHP comments
    local comment_pattern = "^%s*(//|/%*|%*|#*)"

    -- Get all lines in the buffer
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    -- Iterate over each line
    for lnum, line in ipairs(lines) do
        -- Check if the line is a comment
        if not string.match(line, comment_pattern) then
            -- Replace . with -> in lines that are not comments
            local new_line = string.gsub(line, '(%w)%.(%w)', '%1->%2')
            vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, { new_line })
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
        replace_dot_with_arrow()
        -- FIXME: EXTREMLY BAD LMAO, will fix/adapt later
        -- add_dollar_to_variables()
    end,
    group = "php_mappings",
})
