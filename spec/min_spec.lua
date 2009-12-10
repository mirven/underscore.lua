require 'luaspec'
_ = require 'underscore'

describe["_.min"] = function()
	describe["when not providing a transformation function"] = function()
		it["should return the smallest item in the list"] = function()
			input = { 1,2,3,2,1 }
			result = _.min(input)
			expect(result).should_be(1)
		end	
	end
	
	describe["when providing a transformation function"] = function()
		it["should item in the list that has the smallest tranformed value"] = function()
			input = { 1,2,3 }
			result = _.min(input, function(i) return -i end)
			expect(result).should_be(3)
		end
	end	
end


spec:report(true)
