require 'luaspec'
require 'underscore'

describe["_.push"] = function()
	before = function()
		input = { 1,2 }
		result = _.push(input, 3)
	end
	
	it["should add the item onto the end of the array"] = function()		
		expect(#result).should_be(3)
		expect(result[1]).should_be(1)
		expect(result[2]).should_be(2)
		expect(result[3]).should_be(3)
	end	
	
	it["should return the input array"] = function()
		expect(result).should_be(input)	
	end
end

spec:report(true)