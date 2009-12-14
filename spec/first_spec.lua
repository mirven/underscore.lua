require 'spec_helper'

describe["_.first"] = function()
	it["should return the first item"] = function()
		input = { 1,2,3,4 }
		result = _.first(input)
		expect(result).should_be(1)
	end	
	
	describe["when passing in a size"] = function()
		it["should return an array with the first n items"] = function()
			input = { 1,2,3,4 }
			result = _.first(input,2)
			expect(result).should_equal {1,2}
		end
	end
end

spec:report(true)