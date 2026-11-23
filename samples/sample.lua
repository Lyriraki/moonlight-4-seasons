-- Lua sample: table, function, metatable, closure
local MAX_ITEMS = 100
local name = "Alex"
local ratio = 3.14

--[[
  Block comment:
  a simple class built with a metatable
]]
local Animal = {}
Animal.__index = Animal

function Animal.new(species, sound)
  local self = setmetatable({}, Animal)
  self.species = species
  self.sound = sound or "..."
  return self
end

function Animal:speak()
  return string.format("%s makes a %s sound", self.species, self.sound)
end

local function fibonacci(n)
  if n <= 1 then
    return n
  end
  return fibonacci(n - 1) + fibonacci(n - 2)
end

local function counter()
  local count = 0
  return function()
    count = count + 1
    return count
  end
end

local config = {
  host = "127.0.0.1",
  port = 8080,
  debug = false,
  tags = { "web", "api", [3] = "lua" },
}

local dog = Animal.new("Dog", "woof")
print(dog:speak(), #config.tags, 0xFF)

for i = 1, 5 do
  if i % 2 == 0 and config.debug ~= true then
    print("Even:", i, fibonacci(i))
  elseif i == 5 then
    goto done
  end
end

for key, value in pairs(config) do
  print(key .. " = " .. tostring(value))
end

::done::
local next = counter()
print(next(), next(), nil)
