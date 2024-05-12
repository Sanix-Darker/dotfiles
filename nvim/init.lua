_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_chunks',
    },
    modpaths = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_modpaths',
    }
}

vim.cmd('source ~/.config/nvim/config.vim')

-- The list of available plugins
require('plugins')
-- To speed up the start(cache)
require('impatient')
-- All set configurations
require('set_config')
-- to import plugins configurations
require('plugins_config')
-- for my keymaps
require('keymaps')
-- lsp configurations
require('lsp_config')

function DockerExecute(sql_query, sql_command, image_name)
    -- Replace the placeholder with the selected text
    local command = "echo -ne '" .. sql_query .. "' |\
    docker exec -i $(\
        docker ps | \
        grep ".. image_name .. " | \
        awk '{print $1}'\
    ) " .. sql_command
    print(command)

    -- Execute the command and capture the output
    local output = vim.fn.systemlist(command)
    -- Format the output as a single string
    local output_str = table.concat(output, "\n")

    print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
    -- Display the output in the command section
    local success, _ = pcall(function()
        vim.api.nvim_command("echo '" .. vim.fn.escape(output_str, "'") .. "'")
        return true
    end)
    -- in case of error just simple print
    if not success then
        print(output_str)
    end
end

function ExecutePostgresSQLQuery(sql_config, sql_query)
    print("Psql")
    local image_name = 'postgres'
    local cli = 'psql'

    local sql_command = "bash -c 'PGPASSWORD=".. sql_config.password ..
        " ".. cli ..
        " -h ".. sql_config.hostname ..
        " -p ".. sql_config.port ..
        " -U ".. sql_config.username ..
        " -d ".. sql_config.database ..
        "'"
    -- CURSED af lol,
    -- FIXME: here am always considering that " '" is the starting quote
    -- and "'" is the end quote
    -- doing some guessing replace with XZdd as "'"
    local formated_sql_query = string.gsub(sql_query, " '", " XZdd\\XZdd")
    formated_sql_query = string.gsub(formated_sql_query, "'", "\\''")
    formated_sql_query = string.gsub(formated_sql_query, "XZdd", "'")
    DockerExecute(formated_sql_query, sql_command, image_name)
end

function ExecuteMySQLQuery(sql_config, sql_query)
    print("Mysql")
    local image_name = 'mysql'
    local cli = 'mysql'

    local sql_command = cli ..
        " -h ".. sql_config.hostname ..
        " -P ".. sql_config.port ..
        " -u ".. sql_config.username ..
        " -p".. sql_config.password ..
        " -D '".. sql_config.database .. "'"

    DockerExecute(sql_query, sql_command, image_name)
end

function RunMySqlQuery()
    local sql_config = {
        username = 'u',
        password = 'p',
        database = 'TESTDB',
        hostname = 'localhost',
        port = '3306'
    }
    local sql_query = table.concat(vim.fn.getline("'<", "'>"), "\n")
    ExecuteMySQLQuery(sql_config, sql_query)
end

function RunPostgresSqlQuery()
    local sql_config = {
        username = 'u',
        password = 'p',
        database = 'TESTDB',
        hostname = 'localhost',
        port = '5432'
    }
    local sql_query = table.concat(vim.fn.getline("'<", "'>"), "\n")
    ExecutePostgresSQLQuery(sql_config, sql_query)
end

-- Define a custom command to execute the MySQL query
vim.cmd("command! -range ExecuteMySQLQuery :lua RunMySqlQuery()")
vim.cmd("command! -range ExecutePostgresSQLQuery :lua RunPostgresSqlQuery()")
