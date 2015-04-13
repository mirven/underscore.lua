-- Copyright (c) 2009 Marcus Irven
--  
-- Permission is hereby granted, free of charge, to any person
-- obtaining a copy of this software and associated documentation
-- files (the "Software"), to deal in the Software without
-- restriction, including without limitation the rights to use,
-- copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the
-- Software is furnished to do so, subject to the following
-- conditions:
--  
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
--  
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
-- OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
-- HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
-- WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- OTHER DEALINGS IN THE SOFTWARE.

--- Underscore is a set of utility functions for dealing with 
-- iterators, arrays, tables, and functions.

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

function Underscore.range(start_i, end_i, step)
	if end_i == nil then
		end_i = start_i
		start_i = 1
	end
	step = step or 1
	local range_iter = coroutine.wrap(function() 
		for i=start_i, end_i, step do
			coroutine.yield(i)
		end
	end)
	return Underscore:new(range_iter)
end

function Underscore.rangeV2(start_i, end_i, step)
	if end_i == nil then
		end_i = start_i
		start_i = 1
	end
	step = step or 1
	return coroutine.wrap(function() 
		for i=start_i, end_i, step do
			coroutine.yield(i)
		end
	end)
end

-- adds a universal table iterator
Underscore.table_iterator = function(table)
	return coroutine.wrap(function() 
	for key, value in pairs(table) do
		coroutine.yield({key = key, value = value}) end
	end)
end

--- Identity function. This function looks useless, but is used throughout Underscore as a default.
-- @name _.identity
-- @param value any object
-- @return value
-- @usage _.identity("foo")
-- => "foo"
function Underscore.identity(value)
	return value
end

-- chaining

function Underscore:chain()
	self.chained = true
	return self
end

function Underscore:value()
	return self._val
end

-- iter

Underscore.funcs.each = (function()
	local inner
	inner = function(iter, func)
		local _ = iter()
		if _ then
			func(_)
			return inner(iter, func) end
	end
	local each = function(list_or_iter, func)
		inner(Underscore.iter(list_or_iter), func)
		return list_or_iter end
	return each
end)()

function Underscore.funcs.map(list, func)
	local mapped = {}
	for i in Underscore.iter(list) do
		mapped[#mapped+1] = func(i)
	end	
	return mapped
end

function Underscore.funcs.reduce(list, memo, func)	
	for i in Underscore.iter(list) do
		memo = func(memo, i)
	end
	return memo
end

function Underscore.funcs.detect(list, func)
	for i in Underscore.iter(list) do
		if func(i) then return i end
	end	
	return nil	
end

Underscore.funcs.detect_predicate = (function()
	local detect_predicate = function(list, func)
		local condition
		Underscore.funcs.any(list, Underscore.funcs.wrap(func, function(callback, item)
			condition = callback(item)
			return condition end))
		return condition
	end
	return detect_predicate
end)()

function Underscore.funcs.select(list, func)
	local selected = {}
	for i in Underscore.iter(list) do
		if func(i) then selected[#selected+1] = i end
	end
	return selected
end

function Underscore.funcs.reject(list, func)
	local selected = {}
	for i in Underscore.iter(list) do
		if not func(i) then selected[#selected+1] = i end
	end
	return selected
end

function Underscore.funcs.all(list, func)
	func = func or Underscore.identity
	
	-- TODO what should happen with an empty list?
	for i in Underscore.iter(list) do
		if not func(i) then return false end
	end
	return true
end

function Underscore.funcs.any(list, func)
	func = func or Underscore.identity

	-- TODO what should happen with an empty list?	
	for i in Underscore.iter(list) do
		if func(i) then return true end
	end	
	return false
end

function Underscore.funcs.include(list, value)
	for i in Underscore.iter(list) do
		if i == value then return true end
	end	
	return false
end

function Underscore.funcs.invoke(list, function_name, ...)
	local args = {...}
	Underscore.funcs.each(list, function(i) i[function_name](i, unpack(args)) end)
	return list
end

function Underscore.funcs.pluck(list, propertyName)
	return Underscore.funcs.map(list, function(i) return i[propertyName] end)
end

function Underscore.funcs.min(list, func)
	func = func or Underscore.identity
	
	return Underscore.funcs.reduce(list, { item = nil, value = nil }, function(min, item) 
		if min.item == nil then
			min.item = item
			min.value = func(item)
		else
			local value = func(item)
			if value < min.value then
				min.item = item
				min.value = value
			end
		end
		return min
	end).item
end

function Underscore.funcs.max(list, func)
	func = func or Underscore.identity
	
	return Underscore.funcs.reduce(list, { item = nil, value = nil }, function(max, item) 
		if max.item == nil then
			max.item = item
			max.value = func(item)
		else
			local value = func(item)
			if value > max.value then
				max.item = item
				max.value = value
			end
		end
		return max
	end).item
end

Underscore.funcs.to_array = (function ()
	return function (iter)
		return Underscore.funcs.map (iter, function (item) return item end)
	end
end)()

function Underscore.funcs.reverse(list)
	local reversed = {}
	Underscore.funcs.each(list, function(item) table.insert(reversed, 1, item) end)
	return reversed
end

function Underscore.funcs.sort(iter, comparison_func)
	local array = iter
	if type(iter) == "function" then
		array = Underscore.funcs.to_array(iter)
	end
	table.sort(array, comparison_func)
	return array
end

-- usage: simple_reduce({...}, callback), where callback = function(x, y) <body> end
-- simplifies a reduce function by ditching the memo base case
-- @param : list_or_iter, following the underscoreLua specs
-- @param : func, a callback of the form x -> y -> list of z
-- @return : a list
Underscore.funcs.simple_reduce = (function()
	local simple_reduce = function(list_or_iter, func)
		local iter = Underscore.iter(list_or_iter)
		local _ = iter()
		return Underscore.funcs.reduce(iter, _, func) end
	return simple_reduce
end)()

-- usage: multi_map({{...}, {...}, ...}, callback), where callback = function(<number of items in arg1>) <body> end
-- provides a map function for an arbitrary number of lists and/or iterators
-- @param : lists_or_iters, a list of lists and/or iterators following the underscoreLua specs
-- @param : func, a callback that takes the same amount of arguments as there are items in lists_or_iters
-- the function stops execution immediately upon finding a nil value in any of the items in each of the lists_or_iters
-- the use of iterators or lists with holes is therefore discouraged, a very useful side-effect of this behaviour is that
-- the function will cater itself towards the iterator or list with the least amount of items
-- @return : a list
Underscore.funcs.multi_map = (function()
	local inner
	inner = function(iters, func, accumulator)
		local _
		local _s = {}
		if Underscore.funcs.all(iters, function(iter)
			_ = iter()
			table.insert(_s, _)
			return _ end) then
		table.insert(accumulator, func(unpack(_s)))
		return inner(iters, func, accumulator) end
	end
	local multi_map = function(lists_or_iters, func)
		local accumulator = {}
		local iters = Underscore.funcs.map(lists_or_iters, Underscore.iter)
		inner(iters, func, accumulator)
		return accumulator end
	return multi_map
end)()

-- our classic zip function, has almost the same signature as multi-map, but omits the callback
Underscore.funcs.zip = (function()
	local zip = function (lists_or_iters)
		return Underscore.funcs.multi_map(lists_or_iters, function(...) return {...} end)
	end
	return zip
end)()

Underscore.funcs.each_while = (function()
	local each_while = function (lists_or_iters, func, predicate)
		func = Underscore.funcs.wrap(func, function(callback, ...)
			local go = predicate(...)
			if go then callback(...) end
			return go end)
		Underscore.funcs.all(lists_or_iters, func) end
	return each_while
end)()

Underscore.funcs.each_untill = (function()
	local each_untill = function (lists_or_iters, func, predicate)
		predicate = Underscore.funcs.negate(predicate)
		Underscore.funcs.each_while(lists_or_iters, func, predicate) end
	return each_untill
end)()

-- arrays

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

function Underscore.funcs.rest(array, index)
	index = index or 2
	local rest = {}
	for i=index,#array do
		rest[#rest+1] = array[i]
	end
	return rest
end

function Underscore.funcs.slice(array, start_index, length)
	local sliced_array = {}
	
	start_index = math.max(start_index, 1)
	local end_index = math.min(start_index+length-1, #array)
	for i=start_index, end_index do
		sliced_array[#sliced_array+1] = array[i]
	end
	return sliced_array
end

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

function Underscore.funcs.push(array, item)
	table.insert(array, item)
	return array
end

function Underscore.funcs.pop(array)
	return table.remove(array)
end

Underscore.funcs.clear = (function ()
	return function (array)
		Underscore.funcs.safe_each (array, function () Underscore.funcs.pop (array) end)
	end
end)()

Underscore.funcs.append = (function ()
	return function (array, ...)
		local acc = {unpack (array)}  -- identity, abstract away later
		Underscore.funcs.each ({...}, function (item) Underscore.funcs.push (acc, item) end)
		return acc
	end
end)()

Underscore.funcs.destructive_append = (function ()
	return function (array, ...)
		Underscore.funcs.each ({...}, function (item) Underscore.funcs.push (array, item) end)
		return array
	end
end)()

Underscore.funcs.append_all = (function ()
	return function (array, ...)
		local acc = {unpack (array)}  -- identity, abstract away later
		Underscore.funcs.each ({...}, function (item) Underscore.funcs.destructive_append (acc, unpack (item)) end)
		return acc
	end
end)()

Underscore.funcs.flatten_once = (function ()
	return function (array)
		if Underscore.funcs.is_empty (array) then return array end
		local _ = Underscore.funcs.first (array)
		if #array == 1 then return _ end
		return Underscore.funcs.append_all (_, unpack (Underscore.funcs.rest (array))) end
end)()

Underscore.funcs.safe_each = (function ()
	return function (list, func) return Underscore.funcs.each (Underscore.rangeV2 (1, #list), func) end
end)()

function Underscore.funcs.shift(array)
	return table.remove(array, 1)
end

function Underscore.funcs.unshift(array, item)
	table.insert(array, 1, item)
	return array
end

Underscore.funcs.grab = (function ()
	return function (list, idx) return table.remove(list, idx) end
end)()

function Underscore.funcs.join(array, separator)
	return table.concat(array, separator)
end

Underscore.funcs.shuffle = (function ()
	return function (list)
		math.randomseed (os.time ())
		list = {unpack (list)}
		local acc = {}
		Underscore.funcs.safe_each (list, function () Underscore.funcs.push (acc, Underscore.funcs.grab(list, math.random (#list))) end)
		return acc
	end
end)()

-- objects

function Underscore.funcs.keys(obj)
	local keys = {}
	for k,v in pairs(obj) do
		keys[#keys+1] = k
	end
	return keys
end

function Underscore.funcs.values(obj)
	local values = {}
	for k,v in pairs(obj) do
		values[#values+1] = v
	end
	return values
end

function Underscore.funcs.extend(destination, source)
	for k,v in pairs(source) do
		destination[k] = v
	end	
	return destination
end

function Underscore.funcs.is_empty(obj)
	return next(obj) == nil
end

-- Originally based on penlight's deepcompare() -- http://luaforge.net/projects/penlight/
function Underscore.funcs.is_equal(o1, o2, ignore_mt)
	local ty1 = type(o1)
	local ty2 = type(o2)
	if ty1 ~= ty2 then return false end
	
	-- non-table types can be directly compared
	if ty1 ~= 'table' then return o1 == o2 end
	
	-- as well as tables which have the metamethod __eq
	local mt = getmetatable(o1)
	if not ignore_mt and mt and mt.__eq then return o1 == o2 end
	
	local is_equal = Underscore.funcs.is_equal
	
	for k1,v1 in pairs(o1) do
		local v2 = o2[k1]
		if v2 == nil or not is_equal(v1,v2, ignore_mt) then return false end
	end
	for k2,v2 in pairs(o2) do
		local v1 = o1[k2]
		if v1 == nil then return false end
	end
	return true
end

-- functions

function Underscore.funcs.compose(...)
	local function call_funcs(funcs, ...)
		if #funcs > 1 then
			return funcs[1](call_funcs(Underscore.funcs.rest(funcs), ...))
		else
			return funcs[1](...)
		end
	end
	
	local funcs = {...}
	return function(...)
		return call_funcs(funcs, ...)
	end
end

function Underscore.funcs.wrap(func, wrapper)
	return function(...)
		return wrapper(func, ...)
	end
end

function Underscore.funcs.curry(func, argument)
	return function(...)
		return func(argument, ...)
	end
end

Underscore.funcs.multi_curry = (function()
	local multi_curry = function (func, ...)
		Underscore.funcs.each ({...}, function (arg) func = Underscore.funcs.curry(func, arg) end)
		return function(...) return func(...) end
	end
	return multi_curry
end)()

Underscore.funcs.negate = (function()
	local negate = function (predicate)
			predicate = Underscore.funcs.wrap(predicate, function(callback, ...)
			return not callback(...) end)
		return predicate end
	return negate
end)()

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

return Underscore:new()
