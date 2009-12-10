require 'luaspec'
require 'luamock'
_ = require 'underscore'

describe["_.curry"] = function()
	it["should use the provided argument as the first argument for calls"] = function()
		func = Mock:new()
		
		curried_func = _.curry(func, "a")
		curried_func("b", "c")
		
		expect(func).was_called_with("a", "b", "c")
	end
end


spec:report(true)
