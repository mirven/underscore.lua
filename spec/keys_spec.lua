require 'luaspec'
_ = require 'underscore'

describe["_.keys"] = function()
	it["should return an array with all property names"] = function()
		input = { a = 1, b = 2, c = 3 }
		keys = _.keys(input)
		expect(#keys).should_be(3)
		expect(_.include(keys, 'a')).should_be(true)
		expect(_.include(keys, 'b')).should_be(true)
		expect(_.include(keys, 'c')).should_be(true)
	end
end

spec:report(true)