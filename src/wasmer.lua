local wasmer = {
    Bytes = require "wasmer.Bytes",
    Compiler = require "wasmer.Compiler",
    Config = require "wasmer.Config",
    Engine = require "wasmer.Engine",
    Externs = require "wasmer.Externs",
    Features = require "wasmer.Features",
    Imports = require "wasmer.Imports",
    Exports = require "wasmer.Exports",
    Instance = require "wasmer.Instance",
    Module = require "wasmer.Module",
    Name = require "wasmer.Name",
    Store = require "wasmer.Store",
    Target = require "wasmer.Target",
    Triple = require "wasmer.Triple",
    Value = require "wasmer.Value",
    Values = require "wasmer.Values",
    wat2wasm = require "wasmer.wat2wasm"
}

-- for name, module in pairs(wasmer) do
--     _G[name] = module
-- end

_G.Bytes = wasmer.Bytes
_G.Engine = wasmer.Engine
_G.Store = wasmer.Store
_G.Module = wasmer.Module
_G.Imports = wasmer.Imports
_G.Exports = wasmer.Exports
_G.Instance = wasmer.Instance
_G.Value = wasmer.Value
_G.Values = wasmer.Values

-- ---@param path string
-- function load(path) end

return wasmer
