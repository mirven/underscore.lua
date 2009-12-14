require 'spec_helper'

describe["chaining"] = function()
	it["should be able to chain calls and retrieve the value"] = function()
		result = _({ 1,2,3 }):chain():map(function(i) return i*2 end):map(function(i) return i*2 end):value()
		
		expect(result).should_equal {4,8,12}
	end
end

spec:report(true)
