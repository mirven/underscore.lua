require 'luaspec'
_ = require 'underscore'

describe["_.slice"] = function()
	before = function()
		input = { 1,2,3,4 }
		result = _.slice(input, 2,2)
	end
	
	it["should return the values of the input starting at the specified index and the specified length"] = function()
		expect(#result).should_be(2)
		expect(result[1]).should_be(2)
		expect(result[2]).should_be(3)
	end
	
	describe["when requesting more items than are available"] = function()
		before = function()
			input = { 1,2,3,4 }
			result = _.slice(input, 2,5)
		end
	
		it["should return all the values of the input after the specified index"] = function()
			expect(#result).should_be(3)
			expect(result[1]).should_be(2)
			expect(result[2]).should_be(3)
			expect(result[3]).should_be(4)
		end
	end
end

spec:report(true)