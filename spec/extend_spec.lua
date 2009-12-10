require 'luaspec'
_ = require 'underscore'

describe["_.extend"] = function()
	before = function()
		source = { a = 1 }
		destination = { b = 2, c = 3 }
		result = _.extend(source, destination)
	end
	
	it["should add all values from the destination table into the source table"] = function()
		expect(result.a).should_be(1)
		expect(result.b).should_be(2)
		expect(result.c).should_be(3)
	end
	
	it["should return the source table"] = function()		
		expect(result).should_be(source)
	end
end

spec:report(true)