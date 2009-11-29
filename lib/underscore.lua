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

-- chaining
function Underscore:chain()
	self.chained = true
	return self
end

function Underscore:value()
	return self._val
end

-- lists
function Underscore.funcs.map(list, func)
	local mapped = {}
	for i=1,#list do
		mapped[#mapped+1] = func(list[i])
	end
	
	return mapped
end

function Underscore.funcs.reduce(list, memo, func)	
	for i=1,#list do
		memo = func(memo, list[i])
	end	
	return memo
end

function Underscore.funcs.each(list, func)
	for i=1,#list do
		func(list[i])
	end
end

function Underscore.funcs.detect(list, func)
	for i=1,#list do
		if func(list[i]) then return list[i] end
	end	
	return nil	
end

function Underscore.funcs.select(list, func)
	local selected = {}
	for i=1,#list do
		if func(list[i]) then selected[#selected+1] = list[i] end
	end

	return selected
end

function Underscore.funcs.reject(list, func)
	local selected = {}
	for i=1,#list do
		if not func(list[i]) then selected[#selected+1] = list[i] end
	end
	return selected
end

function Underscore.funcs.all(list, func)
	-- TODO what should happen with an empty list?
	local selected = {}
	for i=1,#list do
		if (func and not func(list[i])) or (not func and not list[i]) then return false end
	end
	return true
end

function Underscore.funcs.any(list, func)
	-- TODO what should happen with an empty list?	
	local selected = {}
	for i=1,#list do
		if (func and func(list[i])) or (not func and list[i]) then return true end
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