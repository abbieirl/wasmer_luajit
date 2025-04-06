local cffi = require "cffi"
local ffi = require("ffi")

---A collection of exports.
---@class Exports
---@field ptr userdata
local Exports = {}
Exports.__index = Exports

---@return Exports
function Exports.new()
    local self = setmetatable({}, Exports)
    local exportTypeVec = ffi.new("wasm_exporttype_vec_t")
    cffi.wasm_exporttype_vec_new_empty(exportTypeVec)
    self.ptr = exportTypeVec
    return self
end

---@return number
function Exports:size()
    ---@diagnostic disable-next-line
    return tonumber(self.ptr.size)
end

return Exports
