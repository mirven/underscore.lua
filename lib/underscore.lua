Underscore = {}
Underscore.__index = Underscore

function Underscore.__call(_, o)
	return Underscore:new(o)
end

function Underscore:new(value, chained)
	return setmetatable({ _val = value, chained = chained or false }, self)
end

function Underscore.value_and_chained(list_or_self)
	local chained = false
	if getmetatable(list_or_self) == Underscore then 
		chained = list_or_self.chained
		list_or_self = list_or_self._val 
	end
	return list_or_self, chained
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
function Underscore.map(list_or_self, func)
	local list, chained = Underscore.value_and_chained(list_or_self)
	
	local mapped = {}
	for i=1,#list do
		mapped[#mapped+1] = func(list[i])
	end
	
	return Underscore.value_or_wrap(mapped, chained)
end

function Underscore.reduce(list_or_self, memo, func)	
	local list, chained = Underscore.value_and_chained(list_or_self)
	
	for i=1,#list do
		memo = func(memo, list[i])
	end
	
	return Underscore.value_or_wrap(memo, chained)
end


function Underscore.each(list_or_self, func)
	local list, chained = Underscore.value_and_chained(list_or_self)
	for i=1,#list do
		func(list[i])
	end
end

function Underscore.detect(list_or_self, func)
	local list, chained = Underscore.value_and_chained(list_or_self)
	for i=1,#list do
		if func(list[i]) then return Underscore.value_or_wrap(list[i], chained) end
	end
	
	return Underscore.value_or_wrap(nil, chained)
	
end

function Underscore.select(list_or_self, func)
	local list, chained = Underscore.value_and_chained(list_or_self)
	
	local selected = {}
	for i=1,#list do
		if func(list[i]) then selected[#selected+1] = list[i] end
	end

	return Underscore.value_or_wrap(selected, chained)
end

function Underscore.reject(list_or_self, func)
	local list, chained = Underscore.value_and_chained(list_or_self)
	
	local selected = {}
	for i=1,#list do
		if not func(list[i]) then selected[#selected+1] = list[i] end
	end

	return Underscore.value_or_wrap(selected, chained)
end

function Underscore.all(list_or_self, func)
	local list, chained = Underscore.value_and_chained(list_or_self)

	-- TODO what should happen with an empty list?

	local selected = {}
	for i=1,#list do
		if (func and not func(list[i])) or (not func and not list[i]) then return Underscore.value_or_wrap(false, chained) end
	end

	return Underscore.value_or_wrap(true, chained)
end

function Underscore.any(list_or_self, func)
	local list, chained = Underscore.value_and_chained(list_or_self)
	
	-- TODO what should happen with an empty list?
	
	local selected = {}
	for i=1,#list do
		if (func and func(list[i])) or (not func and list[i]) then return Underscore.value_or_wrap(true, chained) end
	end
	
	return Underscore.value_or_wrap(false, chained)
end

-- object

function Underscore.keys(obj_or_self)
	local obj, chained = Underscore.value_and_chained(obj_or_self)

	local keys = {}
	for k,v in pairs(obj) do
		keys[#keys+1] = k
	end

	return Underscore.value_or_wrap(keys, chained)
end

function Underscore.values(obj_or_self)
	local obj, chained = Underscore.value_and_chained(obj_or_self)

	local values = {}
	for k,v in pairs(obj) do
		values[#values+1] = v
	end

	return Underscore.value_or_wrap(values, chained)
end

function Underscore.extend(obj_or_self, source)
	local obj, chained = Underscore.value_and_chained(obj_or_self)

	for k,v in pairs(source) do
		obj[k] = v
	end

	return Underscore.value_or_wrap(obj, chained)
end

function Underscore.is_empty(obj_or_self)
	local obj, chained = Underscore.value_and_chained(obj_or_self)
	
	return Underscore.value_or_wrap(next(obj) == nil, chained)	
end

function Underscore.functions() 
	return {
		"map",
		"reduce",
		"inject",
		"each",
		"detect",
		"select",
		"reject",
		"any",
		"all",
		"keys",
		"values",
		"extend",
		"is_empty"
	}
end

-- for i, fn in ipairs(Underscore.functions()) do
-- 	local orig_func = Underscore[fn]
-- 	Underscore[fn] = function(obj_or_self, ...)
-- 		local obj, chained = Underscore.value_and_chained(obj_or_self)
-- 	
-- 		return Underscore.value_or_wrap(orig_func(obj, ...), chained)		
-- 	end	 
-- end



_ = Underscore:new()

--- 
local l1 = { 1,2,3, }

local doubler = function(i) return 2*i end

local l2 = _.map(l1, doubler)
print(unpack(l2))

local l3 = _(l1):map(doubler)
print(unpack(l3))

print(unpack(_(l1):chain():value()))

print(unpack(_(l1):chain():map(doubler):map(doubler):value()))

_.each(l1, print)

print(_.reduce(l1, 0, function(memo, i) return memo + i end))

print(_.detect(l1, function(i) return i % 2 == 0 end))
print(_(l1):detect(function(i) return i % 2 == 0 end))

print(unpack(_(l1):select(function(i) return i % 2 == 1 end)))
print(unpack(_(l1):reject(function(i) return i % 2 == 1 end)))

print(_({ true, 1, 10}):all())
print(_({ true, false, 10}):all())

print(_({ 5, 10, 115}):all(function(i) return i > 4 end))
print(_({ 5, 10, 115}):all(function(i) return i > 5 end))

print(unpack(_({ foo = "foov", bar = "barv" }):keys()))
print(unpack(_({ foo = "foov", bar = "barv" }):values()))

assert(_({}):is_empty())
assert(not _({ 5 }):is_empty())
assert(not _({ a = 10 }):is_empty())
assert(_.is_empty({}))
assert(not _.is_empty({ 5 }))
assert(not _.is_empty({ a = 10 }))
