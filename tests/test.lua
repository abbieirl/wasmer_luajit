package.path = package.path .. ";./src/?.lua"
require "wasmer"

local store = Store.new()

local module = Module.new(store, [[
    (module
        (func $add (export "add") (param $a i32) (param $b i32) (result i32)
            (i32.add (local.get $a) (local.get $b))
        )
    )
]])

local instance = Instance.new(store, module)
local add = instance.exports[1]:as_function() --[[@as Function]]

local result = add:call({Value.I32(3), Value.I32(4)})

print(result[1]:of(Value.Type.I32))

return 1
