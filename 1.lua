--[[-- variables type --]]

print(type("Hello, world!"))
print(type(1.4 * 3))
print(type(print))
print(type(type))
print(type(true))
print(type(nil))
print(type(type(_not_exists_variable)))

--[[-- common operations --]]

do
   local a = {x = 1}
   local b = {x = 1}
   print(a == b) --> false (different pointers)
   print(a == a) --> true (the same pointers)
   print("123" < "1234") --> true
   print(123 < 1234) --> true
end

do
   local x = 1
   local y = 2
   local max = (x > y) and x or y;
   print(max) --> 2
end

do
   local x, y = 1, 2
   y, x = x, y --> swap values
   print(x) --> 2
end

--[[-- tables --]]

do
   local d = {}
   d["name"] = "Ivan"
   d["surname"] = "Ivanov"
   print(d.name, d.surname) --> Ivan	Ivanov
end

do
   local d = {name = "Ivan", surname = "Ivanov"}
   print(d.name, d.surname) --> Ivan	Ivanov
end

do
   local d = {}

   for i = 1, 10 do
      d[#d + 1] = i
   end

   print(#d) --> 10
end

do
   local some_table = {x=10, y=20}
   print(some_table["x"]) --> 10
   print(some_table.x) --> 10
   some_table.x = nil --> remove field 'x'
   print(some_table.x) --> nil
end

do
   -- implement `linked list` with the `tables` mechanism

   local list = nil
   for i = 1, 3 do
      list = {next=list, value=i}
   end

   local current_node = list
   while current_node do
      print(current_node.value)
      current_node = current_node.next
   end
end

do
   local poly_line = {
      color = "blue",
      {x = 0, y = 0}
   };

   print(poly_line.color)
   print(poly_line[1].x)

   -- initialize table with non proper keys
   local opnames = {
      ["+"] = "add",
      ["-"] = "sub",
      ["*"] = "mul",
      ["/"] = "div",
   }
end

do
   local d = {x = 1, y = 2, z = 3}
   for key, value in pairs(d) do
      print(key, value)
   end
end

do
   local network = {
      {name = "grauna", ip = "210.26.30.34"},
      {name = "arraial", ip = "210.26.30.23"},
      {name = "lua", ip = "210.26.23.12"},
      {name = "derain", ip = "210.26.23.20"},
   }

   table.sort(network, function (a, b) return a.name > b.name; end)
   for _, item in ipairs(network) do
      print(item.name, item.ip)
   end
end

do
   print(table.concat({"one", "two"}, " "))
   local s = "abcde"
   print(string.byte(s, 1, #s))
   print(s:byte(1, -1))
   print(table.concat({s:byte(1, -1)}, " "))
end

do
   local t = {}
   for i = 1, 10, 1 do
      t[i] = i
   end
   print("t[1]: " .. t[1]) --> 1
   print("#t: " .. #t) --> 10
   table.insert(t, 1, 0)
   print("t[1]: " .. t[1]) --> 0
   print("#t: " .. #t) --> 11
   print("table.concat(t, ', '): " .. table.concat(t, ', ')) --> 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
   table.remove(t, 1)
   print("table.concat(t, ', '): " .. table.concat(t, ', ')) --> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
end

--[[-- strings --]]

do
   local s = "Hello, "
   print(s) --> Hello
   print(s .. "world!") --> Hello, world!
   print("Hello, " .. "world!")
   print(1 .. 2) --> converts to the string and concatenates
end

do
   local s = "Some random string with random words"
   for word in string.gmatch(s, "[a-zA-Z]+") do
      print(word)
   end
end

do
   print([[a multi line
message]])

   -- secure option for automatically quoting long strings
   print([=[asdasdasd"asd'asd]=])
end

do
   local quote = "my some Random"
   print(quote) --> my some Random
   print(#quote) --> 14
   print(string.len(quote)) --> 14
   print(string.gsub(quote, "my", "your")) --> your some Random	1
   print(string.find(quote, "Random")) --> 9	14
   print(string.upper(quote)) --> MY SOME RANDOM
   print(string.lower(quote)) --> my some random
   print(tonumber("123")) --> 123
   print(tonumber("123asd")) --> nil
   print(string.format("5 + 2 = %d", 7)) --> 5 + 2 = 7
   print "without braces" --> without braces
   print {i = 1, j = 2}

   for matched in string.gmatch(quote, "my") do
      print(matched)
   end
end

do
   local function split (value, pattern)
      local result = {}

      for word in string.gmatch(value, pattern) do
         table.insert(result, word)
      end

      return result
   end

   print(table.concat(split("some random with words", "[^%s]+"), ", ")) --> some, random, with, words
end

--[[-- arrays --]]

do
   local some_array = {1, 2, 3 ,4}
end

do
   local arr = {11, 22, 33, 44}
   for i, value in ipairs(arr) do
      print(i, value)
   end
end

do
   local days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
   local reverse_days = {}
   for key, value in pairs(days) do
      reverse_days[value] = key --> values are indicies numbers 1, 2, 3, ...
   end
end

--[[-- functions --]]

do
   local function factorial (n)
      if n == 0 then
         return 1
      else
         return n * factorial(n - 1)
      end
   end

   print(factorial(3))
end

do
   local function add (a)
      local sum = 0
      for _, value in ipairs(a) do
         sum = sum + value
      end
      return sum
   end

   print(add({1, 2, 3, 4}))
end

do
   local function unpack (list, i)
      local i = i or 1
      if list[i] then
         return list[i], unpack(list, i + 1)
      end
   end

   local d = {1, 2, 3}
   local a, b, c = unpack(d)
   print(a, b, c) --> 1	2 3
end

do
   local function add (...)
      local result = 0
      for _, value in ipairs({...}) do
         result = result + value
      end
      return result
   end

   print(add(1, 2, 3, 4)) --> 10
end

do
   local function foo (...)
      local a, b = ...
      print(a, b) --> 1	2
   end

   foo(1, 2, 3)
end

do
   local function interate_on_vararg (...)
      for i = 1, select('#', ...) do -- iterate over total numbers of the args
         local arg = select(i, ...)
         print(arg)
      end
   end

   interate_on_vararg(1, 2, 3)
end

do
   -- clojures
   local function counter()
      local i = 0
      return function ()
         i = i + 1
         return i
      end
   end

   local c = counter()
   print(c())
   print(c())
end

do
   local function chain_print (...)
      print(...)
      return chain_print
   end

   chain_print (1) ("alpha") (2) ("beta") (3) ("gamma")
   chain_print (1) "alpha" (2) "beta" (3) "gamma"
end

do
   local function is_valid_type (param)
      local types = {
         "self",
         "table",
         "nil",
         "boolean",
         "number",
         "string"
      }

      for i = 1, #types do
         if types[i] == param then
            return true
         end
      end

      return false
   end

   local function check_arguments (...)
      local arguments_count = select("#", ...)

      if arguments_count % 2 ~= 0 then
         error("Error! Wrong arguments count `" .. arguments_count .. "' (must be even)")
      end

      for i = 1, arguments_count, 2 do
         local expected_type, value = select(i, ...)

         if not is_valid_type(expected_type) then
            error("Error! Requested wrong data type: `" .. expected_type .. "'")
         end

         if type(value) ~= expected_type then
            error("bad argument #" .. ((i + 1) / 2) .. " type: expected `" .. expected_type ..
                     "', got `" .. type(value) .. "'")
         end
      end
   end

   local function function_with_check_arguments (s, n)
      check_arguments(
         "string", s,
         "number", n
      )

      print("s = " .. s .. ", n = " .. n)
   end

   function_with_check_arguments("q", 1)
end

--[[-- iterators --]]

do
   local function values (list)
      local i = 0
      return function ()
         i = i + 1
         return list[i]
      end
   end

   for value in values{1, 2, 3} do
      print(value)
   end
end

do
   local lines = [[one two
three
four five
six
]]

   local function all_words(lines)
      local lines_iterator = string.gmatch(lines, "[^\n]+")
      local line = lines_iterator()
      local pos = 1

      return function ()
         while line do
            local s, e = string.find(line, "%w+", pos)
            if s then
               pos = e + 1
               return string.sub(line, s, e)
            else
               line = lines_iterator()
               pos = 1
            end
         end

         return nil
      end
   end

   for word in all_words(lines) do
      print(word)
   end
end

-- stateless iterators

do
   local function iter (array, i)
      i = i + 1
      local value = array[i]
      if value then
         return i, value
      end
   end

   local function ipairs (array)
      return iter, array, 0
   end
end

--[[-- exceptions --]]

do
   assert(true, "wrong value!")

   local function always_error ()
      error("always throw error")
   end

   -- always_error() --> throw an error

   local result, errorMessage = pcall(always_error) --> suppress an error
   print(result, errorMessage)
end

--[[-- coroutines --]]

do
   local co = coroutine.create(function () print("Hello!") end)
   print(co)
   print(coroutine.status(co)) --> suspended
   coroutine.resume(co)
   print(coroutine.status(co)) --> dead
end

do
   local co = coroutine.create(function ()
         for i = 1, 2 do
            print("co", i)
            coroutine.yield(i)
         end
         return nil
   end)

   print(coroutine.resume(co))
   print(coroutine.resume(co))
   print(coroutine.resume(co))
end

do
   local co = coroutine.create(function (a, b)
         while (true) do
            coroutine.yield(a + b)
         end

         return nil
   end)

   print(coroutine.resume(co, 1, 2)) -- true 3
end

--[[-- modules --]]

do
   -- global environment _G
   for n in pairs(_G) do print(n) end
end

do
   -- which modules loaded in that session
   for key, value in pairs(package.loaded) do
      print(key)
   end
end

do
   -- force to unload package
   -- package.loaded["io"] = nil

   -- load package again
   -- require "io"

   -- where Lua searches modules
   -- print(package.path)
end

do
   local convert = require "convert"
   print(convert.ft_to_cm(12)) --> 42.48
end

--[[-- metatables --]]

--[[--
__add(a, b)                     for a + b
__sub(a, b)                     for a - b
__mul(a, b)                     for a * b
__div(a, b)                     for a / b
__mod(a, b)                     for a % b
__pow(a, b)                     for a ^ b
__unm(a)                        for -a
__concat(a, b)                  for a .. b
__len(a)                        for #a
__eq(a, b)                      for a == b
__lt(a, b)                      for a < b
__le(a, b)                      for a <= b
__index(a, b)  <fn or a table>  for a.b
__newindex(a, b, c)             for a.b = c
__call(a, ...)                  for a(...)
--]]

do
   -- Lua create new tables without metatables
   local d = {}
   assert(getmetatable(d) == nil)

   -- Set new metable d2 for the table d
   local d2 = {}
   setmetatable(d, d2)
   assert(getmetatable(d) == d2)

   -- metatables have only tables and strings
   print(getmetatable("hi"))
end

do
   local Set = {}

   function Set.new (array)
      local result = setmetatable({}, Set.metatable)

      for _, value in ipairs(array) do
         result[value] = true
      end

      return result
   end

   function Set.check_table (table1)
      if getmetatable(table1) ~= Set.metatable then
         error("Set operations must be on tables only!", 2)
      end
   end

   function Set.union (table1, table2)
      Set.check_table(table1)
      Set.check_table(table2)

      local result = Set.new{}

      for key, _ in pairs(table1) do result[key] = true end
      for key, _ in pairs(table2) do result[key] = true end

      return result
   end

   function Set.intersection (table1, table2)
      Set.check_table(table1)
      Set.check_table(table2)

      local result = Set.new{}

      for key, _ in pairs(table1) do result[key] = table2[key] end

      return result
   end

   function Set.tostring (set)
      Set.check_table(set)

      local result = {}

      for key, _ in pairs(set) do result[#result + 1] = key end

      return "{" .. table.concat(result, ", ") .. "}"
   end

   Set.metatable = {
      __add = Set.union,
      __mul = Set.intersection,
      __tostring = Set.tostring,
   }

   local s1 = Set.new{10, 20, 30}
   local s2 = Set.new{20, 1}
   assert(getmetatable(s1) == getmetatable(s2))

   local s3 = s1 + s2
   print(s3)

   local s4 = s1 * s2
   print(s4)
end

do
   -- prototypes
   local Window = {}
   Window.prototype = {x = 0, y = 0, width = 100, height = 100}
   Window.metatable = {}

   function Window.new (o)
      setmetatable(o, Window.metatable)
      return o
   end

   Window.metatable.__index = function (table, key) -- when Lua can't find key in the table
      return Window.prototype[key]
   end

   -- shortcut for function before
   -- when Lua can't find the key it try to call __index function if it's not nil
   -- but whe Lua see that __index is a table Lua try to search key in that table
   Window.metatable.__index = Window.prototype

   -- the same as __index but for setting values
   -- if it's a table the Lua set name/value to that table
   -- otherwise, Lua call the __newindex if it's a function
   Window.metatable.__newindex = Window.prototype

   local window = Window.new{x = 10, y = 20}
   print(window.height)
end

do
   -- Object Oriented Programming

   -- Base class

   local Account = {
      balance = 0
   }

   function Account:new (param)
      local result = setmetatable(param or {}, self)
      self.__index = self
      return result
   end

   function Account:withdraw (value)
      self.balance = self.balance - value
   end

   function Account:deposit (value)
      self.balance = self.balance + value
   end

   a = Account:new({balance = 0})

   a:deposit(100)
   assert(a.balance == 100)
   assert(Account.balance == 0)

   a:withdraw(10)
   assert(a.balance == 90)
   assert(Account.balance == 0)

   -- Derived class

   local SpecialAccount = Account:new({limit = 1000})

   function SpecialAccount:deposit (value)
      self.balance = self.balance + value + 10
   end

   -- s uses SpecialAccount :deposit method
   local s = SpecialAccount:new()
   s:deposit(10)
   assert(s.balance == 20)
   assert(Account.balance == 0)

   -- a uses Account :deposit method
   a.balance = 0
   a:deposit(100)
   assert(a.balance == 100)
   assert(Account.balance == 0)
end





do
   concurrent = require 'concurrent'

   function hello_world(times)
      for i = 1, times do print('hello world') end
      print('done')
   end

   concurrent.spawn(hello_world, 3)

   concurrent.loop()
end
