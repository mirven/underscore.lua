require 'spec_helper'

describe["_.each"] = function()
	before = function()
		input = { 1,2,3 }
		func = Mock:new()
		result = _.each(input, func)
	end
	
	it["should call the function on each element"] = function()
		expect(func).was_called(3)
	end
	
	it["should return the input"] = function()
		expect(result).should_be(result)
	end
end


spec:report(true)
