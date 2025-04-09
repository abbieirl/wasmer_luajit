local cffi = require "cffi"
local Values = require "wasmer.Values"

---@class Function
---@field ptr userdata
local Function = {}
Function.__index = Function

---@param store Store
---@param type any
---@param callback fun(args: any, results: any)
---@return Function
function Function.new(store, type, callback)
    local self = setmetatable({}, Function)
    return self
end

---@param ptr userdata
---@return Function
function Function.from_ptr(ptr)
    local self = setmetatable({}, Function)
    self.ptr = ptr
    return self
end

function Function:type() end

---@param args Value[]
function Function:call(args)
    local results = Values.new()
    cffi.wasm_func_call(self.ptr, Values.new(args).ptr, results.ptr)
    return results
end

return Function
