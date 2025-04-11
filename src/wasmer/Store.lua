local cffi = require "cffi"
local Engine = require "wasmer.Engine"

---@class Store
---@field ptr userdata
local Store = {}
Store.__index = Store

---@param engine Engine
---@overload fun(): Store
---@overload fun(engine: Engine): Store
---@return Store
function Store.new(engine)
    assert(engine == nil or getmetatable(engine) == Engine, "Expected engine to be an instance of Engine")
    engine = engine or Engine.new()
    local self = setmetatable({}, Store)
    self.ptr = cffi.wasm_store_new(engine.ptr)
    return self
end

return Store
