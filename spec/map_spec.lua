require 'luaspec'
require 'underscore'

describe["_.map"] = function()
	before = function()
		input = { 1,2,3 }
		result = _.map(input, function(i) return i*2 end)
	end
	
	it["should return an array of the same size with all elements transformed by the function"] = function()
		expect(#result).should_be(3)
		expect(result[1]).should_be(2)
		expect(result[2]).should_be(4)
		expect(result[3]).should_be(6)
	end
end


spec:report(true)
