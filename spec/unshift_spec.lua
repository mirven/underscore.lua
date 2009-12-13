require 'luaspec'
_ = require 'underscore'

describe["_.unshift"] = function()
	before = function()
		input = { 1,2 }
		result = _.unshift(input, 3)
	end
	
	it["should add the item onto the beginning of the array"] = function()		
		expect(#result).should_be(3)
		expect(result[1]).should_be(3)
		expect(result[2]).should_be(1)
		expect(result[3]).should_be(2)
	end	
	
	it["should return the input array"] = function()
		expect(result).should_be(input)	
	end
end

spec:report(true)