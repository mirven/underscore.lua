require 'luaspec'
require 'underscore'

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
		expect(#result).should_be(3)
		expect(result[1]).should_be(1)
		expect(result[2]).should_be(4)
		expect(result[3]).should_be(9)
	end
end

spec:report(true)
