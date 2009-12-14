require 'spec_helper'

describe["_.include"] = function()
	it["should return the true if the item is in the list"] = function()
		input = { 1,2,3 }
		result = _.include(input, 2)
		expect(result).should_be(true)
	end
	
	it["should return false when the item is not in the list"] = function()
		input = { 1,2,3 }
		result = _.include(input, 4)
		expect(result).should_be(false)
	end
end


spec:report(true)
