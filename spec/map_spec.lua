require 'spec_helper'

describe["_.map"] = function()
	before = function()
		input = { 1,2,3 }
		result = _.map(input, function(i) return i*2 end)
	end
	
	it["should return an array of the same size with all elements transformed by the function"] = function()
		expect(result).should_equal {2,4,6}
	end
end


spec:report(true)
