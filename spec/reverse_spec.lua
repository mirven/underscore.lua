require 'spec_helper'

describe["_.reverse"] = function()
	it["should return a reversed array"] = function()
		input = { 1,2,3 }
		result = _.reverse(input)
		expect(result).should_equal {3,2,1}
	end
end

spec:report(true)
