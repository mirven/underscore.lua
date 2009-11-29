local previous_underscore = _

local Underscore = { funcs = {} }
Underscore.__index = Underscore

function Underscore.__call(_, value)
	return Underscore:new(value)
end

function Underscore:new(value, chained)
	return setmetatable({ _val = value, chained = chained or false }, self)
end

function Underscore.value_and_chained(value_or_self)
	local chained = false
	if getmetatable(value_or_self) == Underscore then 
		chained = value_or_self.chained
		value_or_self = value_or_self._val 
	end
	return value_or_self, chained
end

function Underscore.value_or_wrap(value, chained)
	if chained then value = Underscore:new(value, true) end
	return value
end

function Underscore.iter(list_or_iter)
	if type(list_or_iter) == "function" then return list_or_iter end
	
	return coroutine.wrap(function() 
		for i=1,#list_or_iter do
			coroutine.yield(list_or_iter[i])
		end
	end)
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
	-- TODO what should happen with an empty list?
	local selected = {}
	for i in Underscore.iter(list) do
		if (func and not func(i)) or (not func and not i) then return false end
	end
	return true
end

function Underscore.funcs.any(list, func)
	-- TODO what should happen with an empty list?	
	local selected = {}
	for i in Underscore.iter(list) do
		if (func and func(i)) or (not func and i) then return true end
	end	
	return false
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

for fn, func in pairs(Underscore.funcs) do
	Underscore[fn] = function(obj_or_self, ...)
		local obj, chained = Underscore.value_and_chained(obj_or_self)	
		return Underscore.value_or_wrap(func(obj, ...), chained)		
	end	 
end

function Underscore:no_conflict()
  _ = previous_underscore
  return self
end

_ = Underscore:new()