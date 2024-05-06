local function fold_functions()
    vim.cmd("normal! zM")
end

local function unfold_functions()
    vim.cmd("normal! zR")
end

local function_folded = false

local function toggle_function_folding()
    if function_folded then
        unfold_functions()
    else
        fold_functions()
    end
    function_folded = not function_folded
end

return {
    toggle_function_folding = toggle_function_folding,
    fold_functions = fold_functions,
    unfold_functions = unfold_functions
}
