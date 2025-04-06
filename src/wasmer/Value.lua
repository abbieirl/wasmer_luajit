local cffi = require "cffi"
local ffi = require "ffi"

---@class Value
---@field ptr { of: { i32: userdata, i64: userdata, f32: userdata, f64: userdata } }
local Value = {}
Value.Type = {
    I32 = 0,
    I64 = 1,
    F32 = 2,
    F64 = 3,
    ExternRef = 128
}
Value.__index = Value

---@param number number
---@return Value
function Value.I32(number)
    local self = setmetatable({}, Value)
    local value = ffi.new("wasm_val_t")
    value.kind = Value.Type.I32
    value.of.i32 = number
    self.ptr = value
    return self
end

---@param number number
---@return Value
function Value.F32(number)
    local self = setmetatable({}, Value)
    local value = ffi.new("wasm_val_t")
    value.kind = Value.Type.F32
    value.of.f32 = number
    self.ptr = value
    return self
end

---@param number number
---@return Value
function Value.I64(number)
    local self = setmetatable({}, Value)
    local value = ffi.new("wasm_val_t")
    value.kind = Value.Type.I64
    value.of.i64 = number
    self.ptr = value
    return self
end

---@param number number
---@return Value
function Value.F64(number)
    local self = setmetatable({}, Value)
    local value = ffi.new("wasm_val_t")
    value.kind = Value.Type.F64
    value.of.f64 = number
    self.ptr = value
    return self
end

function Value.ExternRef()
    local self = setmetatable({}, Value)
    local value = ffi.new("wasm_val_t")
    value.kind = Value.Type.ExternRef
    value.of.ref = ffi.NULL
    return self
end

---@param ptr userdata
function Value.from_ptr(ptr)
    local self = setmetatable({}, Value)
    self.ptr = ptr --[[@as { of: { i32: userdata, i64: userdata, f32: userdata, f64: userdata } }]]
    return self
end

function Value:of(type)
    if type == Value.Type.I32 then
        return tonumber(self.ptr.of.i32)
    end

    if type == Value.Type.I64 then
        return tonumber(self.ptr.of.i64)
    end

    if type == Value.Type.F32 then
        return tonumber(self.ptr.of.f32)
    end

    if type == Value.Type.F64 then
        return tonumber(self.ptr.of.f64)
    end
end

return Value
