local cffi = require "cffi"
local Config = require "wasmer.Config"

---@class Engine
---@field ptr userdata
---@field UNIVERSAL number
local Engine = { UNIVERSAL = 0 }
Engine.__index = Engine

---@overload fun(): Engine
---@overload fun(config: Config): Engine
---@return Engine
function Engine.new(config)
    assert(config == nil or getmetatable(config) == Config, "Expected config to be an instance of Config")
    local self = setmetatable({}, Engine)
    self.ptr = config and cffi.wasm_engine_new_with_config(config.ptr) or cffi.wasm_engine_new()
    return self
end

return Engine
