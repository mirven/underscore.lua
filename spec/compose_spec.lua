require 'spec_helper'

describe["_.compose"] = function()
	it["should create a function that when called calls all the functions like f(g(h()))"] = function()
		f = Mock:new()
		g = Mock:new()
		h = Mock:new()
		
		f:returns(1)
		g:returns(2)
		h:returns(3)
		
		c = _.compose(f,g,h)
		
		result = c(4)  -- f(g(h(4)))
		
		expect(f).was_called_with(2)
		expect(g).was_called_with(3)
		expect(h).was_called_with(4)
		expect(result).should_be(1)
	end
end

spec:report(true)