require 'luaspec'
_ = require 'underscore'

describe["_.reverse"] = function()
	it["should return a reversed array"] = function()
		input = { 1,2,3 }
		result = _.reverse(input)
		
		expect(#result).should_be(3)
		expect(result[1]).should_be(3)
		expect(result[2]).should_be(2)
		expect(result[3]).should_be(1)
	end
end

spec:report(true)
