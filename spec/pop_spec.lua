require 'luaspec'
_ = require 'underscore'

describe["_.pop"] = function()
	before = function()
		input = { 1,2 }
		result = _.pop(input)
	end
	
	it["should return the last item of the array"] = function()		
		expect(result).should_be(2)	
	end	
	
	it["should remove the last item from the array"] = function()
		expect(#input).should_be(1)
		expect(input[1]).should_be(1)
	end
end

spec:report(true)