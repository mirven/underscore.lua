require 'spec_helper'

describe["_.combine"] = function()
	before = function()
		input = { {1,2,3}, {3,2,1,0}, {1,1,1,1,1} }
		result = _.combine(input, function(a,b,c) return a+b+c end)
	end
	
	it["should return an array of size of the first array with the elements of all arrays transformed by the function"] = function()
		expect(result).should_equal {5,5,5}
	end
end


spec:report(true)
