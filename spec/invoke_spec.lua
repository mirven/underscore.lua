require 'luaspec'
require 'luamock'
_ = require 'underscore'

describe["_.invoke"] = function()
	before = function()
		i1 = Mock:new()
		i2 = Mock:new()
		input = { i1,i2 }
		result = _.invoke(input, 'foo')
	end
	
	it["should call the function on each element"] = function()
		expect(i1.foo).was_called(1)
		expect(i2.foo).was_called(1)
	end
	
	it["should return the input"] = function()
		expect(result).should_be(result)
	end
end


spec:report(true)
