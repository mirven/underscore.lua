require 'spec_helper'

describe["_.flatten"] = function()
	before = function()
		input = { 1,2,{3,4,{5}},{{6,7}}}
		result = _.flatten(input)
	end
	
	it["should return an array with each item"] = function()
		expect(result).should_equal {1,2,3,4,5,6,7}
	end
end

spec:report(true)