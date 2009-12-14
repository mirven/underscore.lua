require 'spec_helper'

describe["_.unshift"] = function()
	before = function()
		input = { 1,2 }
		result = _.unshift(input, 3)
	end
	
	it["should add the item onto the beginning of the array"] = function()		
		expect(result).should_equal {3,1,2}
	end	
	
	it["should return the input array"] = function()
		expect(result).should_be(input)	
	end
end

spec:report(true)