package.path = package.path .. ";./src/?.lua"
require "wasmer"

local config = Config.new()
config:set_compiler(Compiler.LLVM)

local engine = Engine.new()
local store = Store.new(engine)

local module = Module.new(store, [[
    (module
        (func $add (export "add") (param $a i32) (param $b i32) (result i32)
            (i32.add (local.get $a) (local.get $b))
        )
    )
]])

local exports = module:exports();

return 1
