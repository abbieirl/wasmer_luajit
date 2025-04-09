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

print("Exports: " .. module:exports():size())

local instance = Instance.new(store, module)
local add = instance.exports[1]:as_function() --[[@as Function]]


local args = Values.new({ Value.new(Value.Type.I32, 3), Value.new(Value.Type.I32, 4) })
local results = Values.new({ Value.new(Value.Type.ExternRef, 0) })

add:call(args, results)

print("Results: " .. results:size())
print(results[1]:of(Value.Type.I32))

return 1
