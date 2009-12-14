require 'spec_helper'

describe["_.any"] = function()
	describe["when providing a truth function"] = function()
		describe["when some of the elements pass the function"] = function()
			before = function()
				input = { 1,2,3 }
				result = _.any(input, function(i) return i%2==0 end)
			end
	
			it["should return true"] = function()
				expect(result).should_be(true)
			end
		end
		
		describe["when none of the elements pass the function"] = function()
			before = function()
				input = { 1,3,5 }
				result = _.any(input, function(i) return i%2==0 end)
			end
	
			it["should return false"] = function()
				expect(result).should_be(false)
			end
		end
	end

	describe["when not providing a truth function"] = function()
		describe["when some elements are not false"] = function()
			before = function()
				input = { 1,2,true,false }
				result = _.any(input)
			end
	
			it["should return true"] = function()
				expect(result).should_be(true)
			end
		end
		
		describe["when none of the elements are not true"] = function()
			before = function()
				input = { false,false }
				result = _.any(input)
			end
	
			it["should return false"] = function()
				expect(result).should_be(false)
			end
		end
	end
end


spec:report(true)
