local cffi = require "cffi"

---@class Target
---@field ptr userdata
local Target = {}
Target.__index = Target

---@param triple Triple
---@param features Features
---@return Target
function Target.new(triple, features)
    local self = setmetatable({}, Target)
    self.ptr = cffi.wasmer_target_new(triple.ptr, features.ptr)
    return self
end

---@private
function Target:__gc()
    cffi.wasmer_target_delete(self.ptr)
end

return Target
