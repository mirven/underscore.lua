require 'luaspec'
require 'underscore'

describe["_.max"] = function()
	describe["when not providing a transformation function"] = function()
		it["should return the largest item in the list"] = function()
			input = { 1,2,3,2,1 }
			result = _.max(input)
			expect(result).should_be(3)
		end	
	end
	
	describe["when providing a transformation function"] = function()
		it["should item in the list that has the largest tranformed value"] = function()
			input = { 1,2,3 }
			result = _.max(input, function(i) return -i end)
			expect(result).should_be(1)
		end
	end	
end


spec:report(true)
