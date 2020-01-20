---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by norguhtar.
--- DateTime: 26.02.19 15:04
---

local pgmoon, _ = pcall(require,"pgmoon")
local inspect = require("inspect")

local _M = {}

function _M:new(obj)
    obj = obj or {}

    if not pgmoon then
        return nil
    end

    local config = obj.config
    if config then
            self.db = pgmoon.new({
                host = config.host,
                port = config.port,
                database = config.database,
                user = config.user or config.username,
                password = config.password
            })
    end

    setmetatable(obj, self)
    self.__index = self
    return obj
end


function _M:connect()
    local db = self.db

    if db then
        local connect, err = db:connect()
        if connect then
            return connect
        else
            return nil, err
        end
    end
end

function _M:query(sql)
    local db = self.db
    if _M:connect() then
        local res = db:query(sql)
        if next(res) then
            return res
        end
    end
end

function _M:begin()
    _M:query("begin")
end

function _M:commit()
    _M:query("commit")
end

function _M:rollback()
    _M:query("rollback")
end

function _M:disconnect()
    local db = self.db
    db:disconnect()
end


return _M