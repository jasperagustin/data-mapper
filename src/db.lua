---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by norguhtar.
--- DateTime: 26.02.19 13:02
---

local lapis = require('data-mapper.db.lapis')
local postgres = require('data-mapper.db.postgres')
local mysql = require('data-mapper.db.mysql')
local pg = require("data-mapper.db.pg")

local db = {}

local drivers = {
    lapis = lapis,
    postgres = postgres,
    mysql = mysql,
    ["tarantool-pg"] = pg
}

function db:new(obj)
    obj = obj or {}

    local config = obj.config
    if drivers[config.driver] then
        return drivers[config.driver]:new(obj)
    else
        return nil
    end
end

return db
