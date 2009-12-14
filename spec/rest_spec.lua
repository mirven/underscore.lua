require 'spec_helper'

describe["_.rest"] = function()
	it["should all items but the first"] = function()
		input = { 1,2,3,4 }
		result = _.rest(input)
		expect(result).should_equal {2,3,4}
	end	

	describe["when specifying a starting index"] = function()
		it["should all items but the first, starting with the specified index"] = function()
			input = { 1,2,3,4 }
			result = _.rest(input, 3)
			expect(result).should_equal {3,4}
		end	
	end
end

spec:report(true)