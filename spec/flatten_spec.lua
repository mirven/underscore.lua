require 'luaspec'
_ = require 'underscore'

describe["_.flatten"] = function()
	before = function()
		input = { 1,2,{3,4,{5}},{{6,7}}}
		result = _.flatten(input)
	end
	
	it["should return an array with each item"] = function()
		expect(#result).should_be(7)
		_.each(result, function(i) expect(i).should_be(i) end)
	end
end

spec:report(true)