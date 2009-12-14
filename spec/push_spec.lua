require 'spec_helper'

describe["_.push"] = function()
	before = function()
		input = { 1,2 }
		result = _.push(input, 3)
	end
	
	it["should add the item onto the end of the array"] = function()		
		expect(result).should_equal {1,2,3}
	end	
	
	it["should return the input array"] = function()
		expect(result).should_be(input)	
	end
end

spec:report(true)