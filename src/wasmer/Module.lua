local cffi = require "cffi"
local wat2wasm = require "wasmer.wat2wasm"
local Store = require "wasmer.Store"

---@class Module
---@field ptr userdata
local Module = {}
Module.__index = Module

---@param store Store
---@param bytes string
---@return Module
function Module.new(store, bytes)
    assert(store and getmetatable(store) == Store, "Expected store to be an instance of Store")
    assert(type(bytes) == "string", "Expected bytes to be a string.")

    local self = setmetatable({}, Module)
    self.ptr = cffi.wasm_module_new(store.ptr, wat2wasm(bytes).ptr)
    return self
end

---@return Imports
function Module:imports()
    local imports = Imports.new()
    cffi.wasm_module_imports(self.ptr, imports.ptr)
    return imports
end

---@return Exports
function Module:exports()
    local exports = Exports.new()
    cffi.wasm_module_exports(self.ptr, exports.ptr)
    return exports
end

---@private
function Module:__gc()
    cffi.wasm_module_delete(self.ptr)
end

return Module
