require 'spec_helper'

describe["_.all"] = function()
	describe["when providing a truth function"] = function()
		describe["when all elements pass the function"] = function()
			before = function()
				input = { 2,4,6 }
				result = _.all(input, function(i) return i%2==0 end)
			end
	
			it["should return true"] = function()
				expect(result).should_be(true)
			end
		end
		
		describe["when all elements don't pass the function"] = function()
			before = function()
				input = { 1,2,3 }
				result = _.all(input, function(i) return i%2==0 end)
			end
	
			it["should return false"] = function()
				expect(result).should_be(false)
			end
		end
	end

	describe["when not providing a truth function"] = function()
		describe["when all elements are not false"] = function()
			before = function()
				input = { 1,2,true }
				result = _.all(input)
			end
	
			it["should return true"] = function()
				expect(result).should_be(true)
			end
		end
		
		describe["when some elements are not true"] = function()
			before = function()
				input = { 1,2,3,false }
				result = _.all(input)
			end
	
			it["should return false"] = function()
				expect(result).should_be(false)
			end
		end
	end

end


spec:report(true)
