local cffi = require "cffi"

---@class Config
---@field ptr userdata
local Config = {}
Config.__index = Config

---@return Config
function Config.new()
    local self = setmetatable({}, Config)
    self.ptr = cffi.wasm_config_new()
    return self
end

---@param engine number
function Config:set_engine(engine)
    cffi.wasm_config_set_engine(self.ptr, engine)
end

---@param compiler Compiler
function Config:set_compiler(compiler)
    cffi.wasm_config_set_compiler(self.ptr, compiler)
end

---@param target Target
function Config:set_target(target)
    cffi.wasm_config_set_target(self.ptr, target.ptr)
end

---@private
function Config:__gc()
    print("Config GC called")
    cffi.wasm_config_delete(self.ptr)
end

return Config
