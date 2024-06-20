-- dockdbnvim
-- common config you could set on all engine
local common_conf = {
    username = 'u',
    password = 'p',
    database = 'TESTDB',
    hostname = 'localhost',
}
local dockdb_ops = {
    mysql = {
        port = '3306'
    },
    postgresql = {
        port = '5432'
    },
    oracle = {
        oracle_sid = 'XE',
        username = 'system', -- this will be used instead of 'u'
        port = '1521'
    },
    mongodb = {
        port = '27017'
    },
    redis = {
        port = '6479'
    },
    memcached = {
        port = '11211'
    }
}
for _, config in pairs(dockdb_ops) do
    for k, v in pairs(common_conf) do
        -- You can use this to set the config for a specific
        -- engine to overide the defaulf from common_conf
        -- like for oracle.
        if config[k] == nil then
            config[k] = v
        end
    end
end
-- then we call dockdb
require("dockdb").setup(dockdb_ops)
