local cffi = require "cffi"

---@class Trap
---@field ptr userdata
local Trap = {}
Trap.__index = Trap

---@param store Store
---@param message Message
---@return Trap
function Trap.new(store, message)
    local self = setmetatable({}, Trap)
    self.ptr = cffi.wasm_trap_new(store.ptr, message.ptr)
    return self
end

return Trap
