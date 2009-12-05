require 'luaspec'
require 'underscore'

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
			expect(#result).should_be(2)
			expect(result[1]).should_be(1)
			expect(result[2]).should_be(2)
		end
	end
end

spec:report(true)