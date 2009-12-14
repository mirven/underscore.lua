require 'spec_helper'

describe["_.reject"] = function()
	before = function()
		input = { 1,2,3 }
		result = _.reject(input, function(i) return i>2 end)
	end
	
	it["should return an array with only elements that don't pass the truth function"] = function()
		expect(result).should_equal {1,2}
	end
end


spec:report(true)
