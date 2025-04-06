local cffi = require "cffi"

---@class Features
---@field ptr userdata
local Features = {}
Features.__index = Features

---@return Features
function Features.new()
    local self = setmetatable({}, Features)
    self.ptr = cffi.wasmer_cpu_features_new()
    return self
end

---@param feature Name
function Features:add(feature)
    cffi.wasmer_cpu_features_add(self.ptr, feature.ptr)
end

---@private
function Features:__gc()
    cffi.wasmer_cpu_features_delete(self.ptr)
end

return Features
