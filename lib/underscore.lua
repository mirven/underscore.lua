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

function Underscore.identity(value)
	return value
end

function Underscore:no_conflict()
  _ = previous_underscore
  return self
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

function Underscore.funcs.each(list, func)
	for i in Underscore.iter(list) do
		func(i)
	end
end

function Underscore.funcs.detect(list, func)
	for i in Underscore.iter(list) do
		if func(i) then return i end
	end	
	return nil	
end

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

function Underscore.funcs.invoke(list, functionName, ...)
	for i in Underscore.iter(list) do
		i[functionName](i, ...)
	end	
end

function Underscore.funcs.pluck(list, propertyName)
	local properties = {}
	for i in Underscore.iter(list) do
		properties[#properties+1] = i[propertyName]
	end	
	return properties
end

function Underscore.funcs.min(list, func)
	func = func or Underscore.identity
	local min = nil
	for i in Underscore.iter(list) do
		if min then
			min = math.min(min, func(i))
		else
			min = func(i)
		end
	end
	return min
end

function Underscore.funcs.max(list, func)
	func = func or Underscore.identity
	
	local max = nil
	for i in Underscore.iter(list) do
		if max then
			max = math.max(max, func(i))
		else
			max = func(i)
		end
	end
	return max
end

function Underscore.funcs.to_array(list)
	local array = {}
	for i in Underscore.iter(list) do
		array[#array+1] = i
	end	
	return array
end

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

-- object
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

function Underscore.funcs.extend(obj, source)
	for k,v in pairs(source) do
		obj[k] = v
	end	
	return obj
end

function Underscore.funcs.is_empty(obj)
	return next(obj) == nil
end

function Underscore.functions() 
	return Underscore.keys(Underscore.funcs)
end

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