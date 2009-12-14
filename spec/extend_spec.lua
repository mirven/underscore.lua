require 'spec_helper'

describe["_.extend"] = function()
	before = function()
		source = { a = 1 }
		destination = { b = 2, c = 3 }
		result = _.extend(source, destination)
	end
	
	it["should add all values from the destination table into the source table"] = function()
		expect(result).should_equal {a=1,b=2,c=3}
	end
	
	it["should return the source table"] = function()		
		expect(result).should_be(source)
	end
end

spec:report(true)