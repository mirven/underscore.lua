require 'luaspec'
require 'underscore'

describe["_.rest"] = function()
	it["should all items but the first"] = function()
		input = { 1,2,3,4 }
		result = _.rest(input)
		expect(#result).should_be(3)
		expect(result[1]).should_be(2)
		expect(result[2]).should_be(3)
		expect(result[3]).should_be(4)
	end	

	describe["when specifying a starting index"] = function()
		it["should all items but the first, starting with the specified index"] = function()
			input = { 1,2,3,4 }
			result = _.rest(input, 3)
			expect(#result).should_be(2)
			expect(result[1]).should_be(3)
			expect(result[2]).should_be(4)
		end	
	end
end

spec:report(true)