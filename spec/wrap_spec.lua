require 'spec_helper'

describe["_.wrap"] = function()
	it["should create a new function that is pased the wrapped function when called"] = function()
		f = Mock:new()
		g = _.wrap(f, function(func, p1, p2)
			func(p1+1,p2+1)
		end)
		
		g(2,4)
		
		expect(f).was_called_with(3,5)
	end
end

spec:report(true)