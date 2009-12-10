require 'luaspec'
_ = require 'underscore'

describe["_.pluck"] = function()
	before = function()
		input = { {i=1}, {i=2}, {i=3} }
		result = _.pluck(input, 'i')
	end
	
	it["should return an array of the same size with the value of the specified property for each input element"] = function()
		expect(#result).should_be(3)
		expect(result[1]).should_be(1)
		expect(result[2]).should_be(2)
		expect(result[3]).should_be(3)
	end
end


spec:report(true)
