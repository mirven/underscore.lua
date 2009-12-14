require 'spec_helper'

describe["_.sort"] = function()
	describe["when not providing a comparison function"] = function()
		before = function()
			input = { 1,3,2 }
			result = _.sort(input)	
		end
		
		it["should return an array sorted by <"] = function()
			expect(result).should_equal {1,2,3}
		end
	end
	
	describe["when providing a comparison function"] = function()
		before = function()
			i1 = { age=10 }
			i2 = { age=8 }
			i3 = { age=20 }
			input = { i1,i2,i3 }
			result = _.sort(input, function(i1, i2) return i1.age < i2.age end)	
		end
		
		it["should return the items sorted by the comparison function"] = function()
			expect(result).should_equal {i2,i1,i3}
		end
	end
end

spec:report(true)
