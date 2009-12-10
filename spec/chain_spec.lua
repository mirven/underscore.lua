require 'luaspec'
_ = require 'underscore'

describe["chaining"] = function()
	it["should be able to chain calls and retrieve the value"] = function()
		result = _({ 1,2,3 }):chain():map(function(i) return i*2 end):map(function(i) return i*2 end):value()
		
		expect(#result).should_be(3)
		expect(result[1]).should_be(4)
		expect(result[2]).should_be(8)
		expect(result[3]).should_be(12)
	end
end

spec:report(true)
