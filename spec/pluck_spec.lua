require 'spec_helper'

describe["_.pluck"] = function()
	before = function()
		input = { {i=1}, {i=2}, {i=3} }
		result = _.pluck(input, 'i')
	end
	
	it["should return an array of the same size with the value of the specified property for each input element"] = function()
		expect(result).should_equal({1,2,3})
	end
end


spec:report(true)
