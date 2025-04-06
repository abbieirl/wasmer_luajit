local cffi = require "cffi"
local ffi = require "ffi"

---@class Values
---@field ptr { size: userdata, data: userdata }
local Values = {}

---@overload fun(): Values
---@overload fun(values: Value[]): Values
function Values.new(values)
    local self = setmetatable({}, Values)
    local valVec = ffi.new("wasm_val_vec_t")

    -- if values then
    --     local valArray = ffi.new("wasm_val_t[?]", #values, values)
    --     cffi.wasm_val_vec_new(valVec, #values, valArray)
    -- else
    --     cffi.wasm_val_vec_new_empty(valVec)
    -- end

    if values then
        -- Create an array of pointers to wasm_val_t
        local ptrArray = ffi.new("wasm_val_t[?]", #values, {ffi.NULL})  -- Create a C-style array of wasm_val_t pointers

        -- Fill the array with pointers to each Value.ptr
        for i = 1, #values do
            ptrArray[i-1] = values[i].ptr  -- Store the pointer of each Value object
        end

        -- Pass the array of pointers to wasm_val_vec_new
        cffi.wasm_val_vec_new(valVec, #values, ptrArray)
    else
        cffi.wasm_val_vec_new_empty(valVec)
    end

    self.ptr = valVec

    return self
end

function Values:size()
    return tonumber(self.ptr.size)
end

function Values:__index(index)
    ---Method indexing
    if type(index) == "string" then
        return Values[index]
    end

    ---Array indexing
    if type(index) == "number" and index > 0 and index <= self:size() then
        return Value.from_ptr(ffi.cast("wasm_val_t**", self.ptr.data)[index - 1])
    end

    return nil
end

return Values
