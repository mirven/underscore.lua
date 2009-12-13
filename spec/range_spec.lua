require 'luaspec'
_ = require 'underscore'

describe["_.range"] = function()
	describe["when only passing a length"] = function()
		it["should iterate from 1 to the length"] = function()
			result = _.range(3):to_array()
			expect(#result).should_be(3)
			expect(result[1]).should_be(1)
			expect(result[2]).should_be(2)
			expect(result[3]).should_be(3)
		end
	end

	describe["when only passing a start and end value"] = function()
		it["should iterate from start to the end inclusively"] = function()
			result = _.range(2,4):to_array()
			expect(#result).should_be(3)
			expect(result[1]).should_be(2)
			expect(result[2]).should_be(3)
			expect(result[3]).should_be(4)
		end
	end

	describe["when passing a start and end value and a step"] = function()
		describe["when step is positive"] = function()
			it["should iterate from start to the end inclusively incremented by step"] = function()
				result = _.range(2,6,2):to_array()
				expect(#result).should_be(3)
				expect(result[1]).should_be(2)
				expect(result[2]).should_be(4)
				expect(result[3]).should_be(6)
			end
		end

		describe["when step is negative"] = function()
			it["should iterate from start to the end inclusively decremented by step"] = function()
				result = _.range(6,2,-2):to_array()
				expect(#result).should_be(3)
				expect(result[1]).should_be(6)
				expect(result[2]).should_be(4)
				expect(result[3]).should_be(2)
			end
		end
	end
	
end


spec:report(true)
