local cffi = require "cffi"
local Trap = require "wasmer.Trap"
local Message = require "wasmer.Message"
local Externs = require "wasmer.Externs"

---@class Instance
---@field ptr userdata
---@field exports Externs
local Instance = {}
Instance.__index = Instance

---@overload fun(store: Store, module: Module): Instance
---@overload fun(store: Store, module: Module, imports: Imports): Instance
function Instance.new(store, module, imports)
    local self = setmetatable({}, Instance)

    imports = imports or Imports.new()
    local trap = Trap.new(store, Message.new())
    self.ptr = cffi.wasm_instance_new(store.ptr, module.ptr, imports.ptr, trap.ptr)

    self.exports = Externs.new()
    cffi.wasm_instance_exports(self.ptr, self.exports.ptr)

    return self
end

return Instance
