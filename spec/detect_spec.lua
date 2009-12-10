require 'luaspec'
_ = require 'underscore'

describe["_.detect"] = function()
	it["should return the first element that passes the test"] = function()
		input = { 1,2,3 }
		result = _.detect(input, function(i) return i>2 end)
		expect(result).should_be(3)
	end
	
	it["should return nil when none of the items pass the test"] = function()
		input = { 1,2,3 }
		result = _.detect(input, function(i) return i>6 end)
		expect(result).should_be(nil)
	end
end


spec:report(true)
