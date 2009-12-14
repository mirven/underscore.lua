require 'spec_helper'

describe["_.shift"] = function()
	before = function()
		input = { 1,2 }
		result = _.shift(input)
	end
	
	it["should return the first item of the array"] = function()		
		expect(result).should_be(1)	
	end	
	
	it["should remove the first item from the array"] = function()
		expect(input).should_equal {2}
	end
end

spec:report(true)