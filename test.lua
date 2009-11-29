require 'lib.underscore'


local l1 = { 1,2,3, }

local doubler = function(i) return 2*i end

function sq(n)
	return coroutine.wrap(function() 
		for i=1,n do
			coroutine.yield(i*i)
		end
	end)
end


local l2 = _.map(l1, doubler)
print(unpack(l2))

local l3 = _(l1):map(doubler)
print(unpack(l3))

print(unpack(_(l1):chain():value()))

print(unpack(_(l1):chain():map(doubler):map(doubler):value()))

_.each(l1, print)
_.each(sq(5), print)
_(sq(5)):each(print)

print(_.reduce(l1, 0, function(memo, i) return memo + i end))

print(_.detect(l1, function(i) return i % 2 == 0 end))
print(_(l1):detect(function(i) return i % 2 == 0 end))

print(unpack(_(l1):select(function(i) return i % 2 == 1 end)))
print(unpack(_(l1):reject(function(i) return i % 2 == 1 end)))
print(unpack(_(l1):reject(function(i) return i % 2 == 0 end)))

print(_({ true, 1, 10}):all())
print(_({ true, false, 10}):all())

print(_({ 5, 10, 115}):all(function(i) return i > 4 end))
print(_({ 5, 10, 115}):all(function(i) return i > 5 end))


print(_({ true, 1, 10}):any())
print(_({ true, false, 10}):any())
print(_({ nil, false, nil}):any())

print(_({ 5, 10, 115}):any(function(i) return i > 4 end))
print(_({ 5, 10, 115}):any(function(i) return i > 5 end))
print(_({ 5, 10, 115}):any(function(i) return i > 200 end))

print(unpack(_({ foo = "foov", bar = "barv" }):keys()))
print(unpack(_.keys({ foo = "foov", bar = "barv" })))
print(unpack(_({ foo = "foov", bar = "barv" }):values()))
print(unpack(_.values({ foo = "foov", bar = "barv" })))

assert(_({}):is_empty())
assert(not _({ 5 }):is_empty())
assert(not _({ a = 10 }):is_empty())
assert(_.is_empty({}))
assert(not _.is_empty({ 5 }))
assert(not _.is_empty({ a = 10 }))

print(unpack(_.functions()))
;
(function()
	local source = { a = 1, b = 2 }
	local dest = { c = 3 }

	_(dest):extend(source)
	assert(dest.a == 1)
	assert(dest.b == 2)
	assert(dest.c == 3)

	assert(source.a == 1)
	assert(source.b == 2)
	assert(source.c == nil)
end)();

(function()
	local source = { a = 1, b = 2 }
	local dest = { c = 3 }

	_.extend(dest, source)
	assert(dest.a == 1)
	assert(dest.b == 2)
	assert(dest.c == 3)

	assert(source.a == 1)
	assert(source.b == 2)
	assert(source.c == nil)
end)();

print(unpack(_(sq(5)):select(function(i) return i > 10 end)))


for ele in _.iter { 'a', 'b', 'c' } do print(ele) end

assert(_.include({ 'a', 'b', 'c'}, 'a'))
assert(not _.include({ 'a', 'b', 'c'}, 'd'))