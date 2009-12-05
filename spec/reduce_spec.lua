require 'luaspec'
require 'underscore'

describe["_.reduce"] = function()
	it["should apply the reduction function to each item in the list"] = function()
		result = _.reduce({1,2,3,4}, 0, function(memo, val) return memo+val end)
		expect(result).should_be(10)

		result = _.reduce({1,2,3,4}, 1, function(memo, val) return memo*val end)
		expect(result).should_be(24)
	end
end


spec:report(true)
