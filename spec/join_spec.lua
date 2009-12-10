require 'luaspec'
_ = require 'underscore'

describe["_.join"] = function()
	describe["when not specifying a separator"] = function()
		it["should return a string with each string concatenated"] = function()
			input = { 'c','a','t' }
			result = _.join(input)
			expect(result).should_be('cat')
		end
	end

	describe["when specifying a separator"] = function()
		it["should return a string with each string concatenated with specified separator"] = function()
			input = { 'c','a','t' }
			result = _.join(input, ",")
			expect(result).should_be('c,a,t')
		end
	end
end

spec:report(true)