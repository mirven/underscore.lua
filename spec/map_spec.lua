require 'spec_helper'

describe["_.map"] = function()
	before = function()
		input1 = { 1,2,3 }
		result_one_iter = _.map(input1, function(i) return i*2 end)
		input2 = { 2,3,4,5 }
		input3 = { 3,4,5,6 }
		result_three_iters = _.map(input1, input2, input3, function(a,b,c) return a+b+c end)
	end

	it["should return an array of the same size with all elements transformed by the function"] = function()
		expect(result_one_iter).should_equal {2,4,6}
	end
	
	it["should return one array of the size of the first argument with all elements transformed by the function"] = function()
		expect(result_three_iters).should_equal {6,9,12}
	end
end


spec:report(true)
