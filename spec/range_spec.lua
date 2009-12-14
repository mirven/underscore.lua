require 'spec_helper'

describe["_.range"] = function()
	describe["when only passing a length"] = function()
		it["should iterate from 1 to the length"] = function()
			result = _.range(3):to_array()
			expect(result).should_equal {1,2,3}
		end
	end

	describe["when only passing a start and end value"] = function()
		it["should iterate from start to the end inclusively"] = function()
			result = _.range(2,4):to_array()
			expect(result).should_equal {2,3,4}
		end
	end

	describe["when passing a start and end value and a step"] = function()
		describe["when step is positive"] = function()
			it["should iterate from start to the end inclusively incremented by step"] = function()
				result = _.range(2,6,2):to_array()
				expect(result).should_equal {2,4,6}
			end
		end

		describe["when step is negative"] = function()
			it["should iterate from start to the end inclusively decremented by step"] = function()
				result = _.range(6,2,-2):to_array()
				expect(result).should_equal {6,4,2}
			end
		end
	end
	
end


spec:report(true)
