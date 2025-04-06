local cffi = require "cffi"

---@class Engine
---@field ptr userdata
---@field UNIVERSAL number
local Engine = { UNIVERSAL = 0 }
Engine.__index = Engine

---@overload fun(): Engine
---@overload fun(config: Config): Engine
---@return Engine
function Engine.new(config)
    local self = setmetatable({}, Engine)
    self.ptr = config and cffi.wasm_engine_new_with_config(config.ptr) or cffi.wasm_engine_new()
    return self
end

---@private
function Engine:__gc()
    print("Engine GC")
    cffi.wasm_engine_delete(self.ptr)
end

return Engine
