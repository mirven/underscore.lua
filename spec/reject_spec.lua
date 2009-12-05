require 'luaspec'
require 'underscore'

describe["_.reject"] = function()
	before = function()
		input = { 1,2,3 }
		result = _.reject(input, function(i) return i>2 end)
	end
	
	it["should return an array with only elements that don't pass the truth function"] = function()
		expect(#result).should_be(2)
		expect(result[1]).should_be(1)
		expect(result[2]).should_be(2)
	end
end


spec:report(true)
