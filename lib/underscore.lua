--- Underscore is a set of utility functions for dealing with 
-- iterators, arrays, tables, and functions.
local previous_underscore = _

local Underscore = { funcs = {} }
Underscore.__index = Underscore

function Underscore.__call(_, value)
	return Underscore:new(value)
end

function Underscore:new(value, chained)
	return setmetatable({ _val = value, chained = chained or false }, self)
end

function Underscore.iter(list_or_iter)
	if type(list_or_iter) == "function" then return list_or_iter end
	
	return coroutine.wrap(function() 
		for i=1,#list_or_iter do
			coroutine.yield(list_or_iter[i])
		end
	end)
end

--- Identity function
-- @name _.identity
-- @param value any object
-- @return value
function Underscore.identity(value)
	return value
end

--- Restores the _ variable and returns the _ object so that 
-- it can be assigned to another variable
-- @name _:no_conflict
function Underscore:no_conflict()
  _ = previous_underscore
  return self
end

-- chaining

--- Starts chaining
-- @name _:chain
function Underscore:chain()
	self.chained = true
	return self
end

--- Returns the value of a chained object
-- @name _:value
function Underscore:value()
	return self._val
end

-- iter

--- Calls func on each item in list
-- @name _.each
-- @param list
-- @param func
-- @usage _.each({1,2,3}, print)
function Underscore.funcs.each(list, func)
	for i in Underscore.iter(list) do
		func(i)
	end
end

--- Produces a new array by mapping each value in iter
-- through a transformation function.
-- @name _.map
-- @param list
-- @param func
-- @usage _.map({1,2,3}, function(i) return i*2 end)
function Underscore.funcs.map(list, func)
	local mapped = {}
	for i in Underscore.iter(list) do
		mapped[#mapped+1] = func(i)
	end	
	return mapped
end

--- Reduces a list of items down to a singular value
-- @name _.reduce
-- @param list items to perform the reduction on
-- @param memo initial state of reduction and each sucessive state should be returned by func
-- @param func reduction function which takes two parameters, the current state and value
-- @usage _.reduce({1,2,3}, 0, function(memo, i) return memo+i end)
function Underscore.funcs.reduce(list, memo, func)	
	for i in Underscore.iter(list) do
		memo = func(memo, i)
	end	
	return memo
end

--- Looks through a list returning the first element that matches 
-- a truth function. The function returns as soon as it finds an
-- acceptable element and doesn't traverse the entire list.
-- @name _.detect
-- @param list
-- @param func
function Underscore.funcs.detect(list, func)
	for i in Underscore.iter(list) do
		if func(i) then return i end
	end	
	return nil	
end

--- Looks through a list and returns a new array containing all
-- items that match a truth function.
-- @name _.select
-- @param list
-- @param func
function Underscore.funcs.select(list, func)
	local selected = {}
	for i in Underscore.iter(list) do
		if func(i) then selected[#selected+1] = i end
	end
	return selected
end

--- Looks through alist and returns a new array containing all
-- items that don't match the truth function.
-- @name _.reject
-- @param list
-- @param func
function Underscore.funcs.reject(list, func)
	local selected = {}
	for i in Underscore.iter(list) do
		if not func(i) then selected[#selected+1] = i end
	end
	return selected
end

--- Returns true if func(item) returns true for all item in items.
-- @name _.all
-- @param list items
-- @param func (optional) 
-- @usage _.all({2,4,8}, function(i) return i%2 end)
function Underscore.funcs.all(list, func)
	func = func or Underscore.identity
	
	-- TODO what should happen with an empty list?
	for i in Underscore.iter(list) do
		if not func(i) then return false end
	end
	return true
end

--- Returns true if func(item) returns true for all item in items.
-- @name _.any
-- @param list items
-- @param func (optional) 
-- @usage _.any({2,4,8}, function(i) return i%2 end)
function Underscore.funcs.any(list, func)
	func = func or Underscore.identity

	-- TODO what should happen with an empty list?	
	for i in Underscore.iter(list) do
		if func(i) then return true end
	end	
	return false
end

--- Returns true if the list include's value
-- @name _.include
-- @param list
-- @param value
function Underscore.funcs.include(list, value)
	for i in Underscore.iter(list) do
		if i == value then return true end
	end	
	return false
end

--- Calls a function with specified name on each item using the colon operator.
-- @name _.invoke
-- @param list
-- @param function_name
-- @param ... (optional) arguments to be passed into the function
-- @return the original list
-- @usage Person = {}; Person.__index = Person
--		function Person:new(name)
--			return setmetatable({ name=name }, self)
--		end
--		function Person:print()
--			print(self.name)
--		end
--		_.invoke({ Person:new("Tom"), Person:new("Dick"), Person:new("Harry") }, "print")
-- => Calls person:print() on each Person
function Underscore.funcs.invoke(list, function_name, ...)
	local args = {...}
	Underscore.funcs.each(list, function(i) i[function_name](i, unpack(args)) end)
end

--- An convenient version of the common use-case of map: extracting a list of properties
-- @name _.pluck
-- @param list
-- @param property_name
-- @return new array containing the property value corresponding to the propery name on each item
-- @usage _.pluck({ {id=1}, {id=2}, {id=3} }, 'id')
-- => { 1, 2, 3 }
function Underscore.funcs.pluck(list, propertyName)
	return Underscore.funcs.map(list, function(i) return i[propertyName] end)
end

--- Returns the item with the smallest value. If a func i spassed it will be used on each value 
-- to generate the criterion by which the value is ranked.
-- @name _.min
-- @param list
-- @param func
-- @return the minimum value
-- @usage _.min({ 5, 2, 15})
-- => 2
-- _.min({ {age=5}, {age=2}, {age=15} }, function(p) return p.age end)
-- => {age=2}
function Underscore.funcs.min(list, func)
	func = func or Underscore.identity
	local min, min_value = nil, nil
	for i in Underscore.iter(list) do
		if min == nil then
			min = i
			min_value = func(i)
		else
			local value = func(i)
			if value < min_value then
				min = i
				min_value = func(i)
			end
		end
	end
	return min
end

--- Returns the item with the largest value. If a func i spassed it will be used on each value 
-- to generate the criterion by which the value is ranked.
-- @name _.max
-- @param list
-- @param func
-- @return the maximum value
-- @usage _.max({ 5, 2, 15})
-- => 15
-- _.max({ {age=5}, {age=2}, {age=15} }, function(p) return p.age end)
-- => {age=15}
function Underscore.funcs.max(list, func)
	func = func or Underscore.identity
	
	local max, max_value = nil, nil
	for i in Underscore.iter(list) do
		if max == nil then
			max = i
			max_value = func(i)
		else
			local value = func(i)
			if value > max_value then
				max = i
				max_value = func(i)
			end
		end
	end
	return max
end

--- Converts the list to an array. This is useful for creating an
-- array from a generator.
-- @name _.to_array
-- @param list
-- @return a new array
-- @usage _.to_array(string.gmatch("dog cat goat", "%S+"))
-- => { "dog", "cat", "goat" }
function Underscore.funcs.to_array(list)
	local array = {}
	for i in Underscore.iter(list) do
		array[#array+1] = i
	end	
	return array
end

--- Iterates over all the items and returns a new array with the items
-- in reverse order
-- @name _.reverse
-- @param list
-- @return a new array
-- @usage _.reverse({ 1, 2, 3})
-- => { 3, 2, 1 }
function Underscore.funcs.reverse(list)
	local reversed = {}
	for i in Underscore.iter(list) do
		table.insert(reversed, 1, i)
	end	
	return reversed
end

--- Sorts all items using a comparison function if provided. Uses table.sort but
-- creates a new array first.
-- @name _.sort
-- @param list
-- @param comparison_func (Optional)
-- @return a new array
-- @usage _.sort({ 10, 2, 5})
-- => { 2, 5, 10 }
function Underscore.funcs.sort(iter, comparison_func)
	local array = Underscore.funcs.to_array(iter)
	table.sort(array, comparison_func)
	return array
end

-- arrays

--- Returns the first element of an array. Optionally it will return an array of the 
-- first n items.
-- @name _.first
-- @param array
-- @param n (Optional)
-- @return the first item or an array of the first n items of n is specified
-- @usage _.first({ 10, 2, 5})
-- => 10
-- _.first({ 10, 2, 5}, 2)
-- => { 10, 2 }
function Underscore.funcs.first(array, n)
	if n == nil then
		return array[1]
	else
		local first = {}
		n = math.min(n,#array)
		for i=1,n do
			first[i] = array[i]			
		end
		return first
	end
end

--- Returns an array of all items except the first. Optionally it will start at index.
-- @name _.rest
-- @param array
-- @param index (Optional)
-- @return an array with the remaining items
-- @usage _.rest({ 1, 2, 3 })
-- => { 2,3 }
-- _.rest({ 1, 2, 3 }, 2)
-- => { 3 }
function Underscore.funcs.rest(array, index)
	index = index or 2
	local rest = {}
	for i=index,#array do
		rest[#rest+1] = array[i]
	end
	return rest
end

--- Returns a section of an array starting with start_index of length items length
-- @name _.slice
-- @param array
-- @param start_index
-- @param length
-- @return an array
-- @usage _.slice({ 1, 2, 3, 4, 5 }, 2, 3)
-- => { 2, 3, 4 }
function Underscore.funcs.slice(array, start_index, length)
	local sliced_array = {}
	
	start_index = math.max(start_index, 1)
	local end_index = math.min(start_index+length-1, #array)
	for i=start_index, end_index do
		sliced_array[#sliced_array+1] = array[i]
	end
	return sliced_array
end

--- Flattens a nested array (the nesting can be to any depth). 
-- @name _.flatten
-- @param array
-- @return the flattened array
-- @usage _.flatten({1, {2}, {3, {{{4}}}}})
-- => { 1, 2, 3, 4 }
function Underscore.funcs.flatten(array)
	local all = {}
	
	for ele in Underscore.iter(array) do
		if type(ele) == "table" then
			local flattened_element = Underscore.funcs.flatten(ele)
			Underscore.funcs.each(flattened_element, function(e) all[#all+1] = e end)
		else
			all[#all+1] = ele
		end
	end
	return all
end

-- objects

--- Returns an array of all the property names in a table
-- @name _.keys
-- @param obj
-- @return an array with the property names (Note: the order is not defined)
-- @usage _.keys { name = "John", age = 25 }
-- => { "name", "age" }
function Underscore.funcs.keys(obj)
	local keys = {}
	for k,v in pairs(obj) do
		keys[#keys+1] = k
	end
	return keys
end

--- Returns an array of all the property values in a table
-- @name _.values
-- @param obj
-- @return an array with the property values (Note: the order is not defined)
-- @usage _.values { name = "John", age = 25 }
-- => { "John", 25 }
function Underscore.funcs.values(obj)
	local values = {}
	for k,v in pairs(obj) do
		values[#values+1] = v
	end
	return values
end

--- Copy all of the properties in the source object over to the destination object. 
-- @name _.values
-- @param destination
-- @param source
-- @return the destination object
-- @usage _.extend({ name = 'moe' }, { age = 50 })
-- => { name = 'moe', age = 50 }
function Underscore.funcs.extend(destination, source)
	for k,v in pairs(source) do
		destination[k] = v
	end	
	return destination
end

--- Returns true if object contains no values. 
-- @name _.is_empty
-- @usage _.is_empty({})
-- => true
-- -.is_empty({ name = "moe" })
-- => false
function Underscore.funcs.is_empty(obj)
	return next(obj) == nil
end

-- functions

--- Returns the composition of a list of functions, where each function consumes the 
-- return value of the function that follows. In math terms, composing the functions 
-- f(), g(), and h() produces f(g(h())). 
-- @name _.compose
-- @usage greet = function(name) return "hi: "..name end
-- exclaim = function(statement) return statement.."!" end
-- welcome = _.compose(print, greet, exclaim)
-- welcome('moe')
-- => hi: moe!
function Underscore.funcs.compose(...)
	local function call_funcs(funcs, ...)
		if #funcs > 1 then
			return funcs[1](call_funcs(_.rest(funcs), ...))
		else
			return funcs[1](...)
		end
	end
	
	local funcs = {...}
	return function(...)
		return call_funcs(funcs, ...)
	end
end

--- Wraps the first function inside of the wrapper function, 
-- passing it as the first argument. This allows the wrapper to 
-- execute code before and after the function runs, adjust the 
-- arguments, and execute it conditionally.
-- @name _.wrap
-- @usage local hello = function(name) return "hello: "..name end
-- hello = _.wrap(hello, function(func, ...)
--   return "before, "..func(...)..", after"
-- end)
-- hello('moe')
-- => before, hello: moe, after
function Underscore.funcs.wrap(func, wrapper)
	return function(...)
		return wrapper(func, ...)
	end
end

--- Returns an array of all function names in this library
-- @name _.functions
-- @usage _.functions()
-- => { 'each', 'map', 'reduce', ... }
function Underscore.functions() 
	return Underscore.keys(Underscore.funcs)
end

-- add aliases
Underscore.methods = Underscore.functions

Underscore.funcs.for_each = Underscore.funcs.each
Underscore.funcs.collect = Underscore.funcs.map
Underscore.funcs.inject = Underscore.funcs.reduce
Underscore.funcs.foldl = Underscore.funcs.reduce
Underscore.funcs.filter = Underscore.funcs.select
Underscore.funcs.every = Underscore.funcs.all
Underscore.funcs.some = Underscore.funcs.any
Underscore.funcs.head = Underscore.funcs.first
Underscore.funcs.tail = Underscore.funcs.rest

local function wrap_functions_for_oo_support()
	local function value_and_chained(value_or_self)
		local chained = false
		if getmetatable(value_or_self) == Underscore then 
			chained = value_or_self.chained
			value_or_self = value_or_self._val 
		end
		return value_or_self, chained
	end

	local function value_or_wrap(value, chained)
		if chained then value = Underscore:new(value, true) end
		return value
	end

	for fn, func in pairs(Underscore.funcs) do
		Underscore[fn] = function(obj_or_self, ...)
			local obj, chained = value_and_chained(obj_or_self)	
			return value_or_wrap(func(obj, ...), chained)		
		end	 
	end
end

wrap_functions_for_oo_support()

_ = Underscore:new()