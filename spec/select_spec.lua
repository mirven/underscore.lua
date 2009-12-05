require 'luaspec'
require 'underscore'

describe["_.select"] = function()
	before = function()
		input = { 1,2,3 }
		result = _.select(input, function(i) return i>2 end)
	end
	
	it["should return an array with only elements that do pass the truth function"] = function()
		expect(#result).should_be(1)
		expect(result[1]).should_be(3)
	end
end


spec:report(true)
