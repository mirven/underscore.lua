require 'spec_helper'

describe["_.iter"] = function()
	describe["when passed an array"] = function()
		it["should iterate over each element in the input"] = function()
			input = { 1,2,3 }
			output = {}
		
			for i in _.iter(input) do
				output[#output+1] = i
			end
			
			expect(output).should_equal {1,2,3}
		end
	end

	describe["when passed an iterator"] = function()
		it["should return the iterator"] = function()
			function sq(n)
				return coroutine.wrap(function() 
					for i=1,n do
						coroutine.yield(i*i)
					end
				end)
			end
			output = {}
		
			for i in _.iter(sq(3)) do
				output[#output+1] = i
			end

			expect(output).should_equal {1,4,9}
		end
	end
end


spec:report(true)
