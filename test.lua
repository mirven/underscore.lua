require 'lib.underscore'


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
print(unpack(_(l1):reject(function(i) return i % 2 == 0 end)))

print(_({ true, 1, 10}):all())
print(_({ true, false, 10}):all())

print(_({ 5, 10, 115}):all(function(i) return i > 4 end))
print(_({ 5, 10, 115}):all(function(i) return i > 5 end))

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
