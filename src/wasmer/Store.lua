local cffi = require "cffi"

---@class Store
---@field ptr userdata
local Store = {}
Store.__index = Store

---@param engine Engine
---@overload fun(): Store
---@overload fun(engine: Engine): Store
---@return Store
function Store.new(engine)
    engine = engine or Engine.new()
    local self = setmetatable({}, Store)
    self.ptr = cffi.wasm_store_new(engine.ptr)
    return self
end

---@private
function Store:__gc()
    cffi.wasm_store_delete(self.ptr)
end

return Store
