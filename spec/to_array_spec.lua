require 'spec_helper'

describe["_.to_array"] = function()
	before = function()
		function sq(n)
			return coroutine.wrap(function() 
				for i=1,n do
					coroutine.yield(i*i)
				end
			end)
		end
		
		result = _.to_array(sq(3))	
	end
	
	it["should return the values produced by the iterator in an array"] = function()
		expect(result).should_equal {1,4,9}
	end
end

spec:report(true)
