require 'luaspec'
require 'luamock'

package.path = "../lib/?.lua;" .. package.path
_ = require 'underscore'

function matchers.should_equal(value, expected)
	if not _.is_equal(value, expected) then
		return false, "expecting "..tostring(expected)..", not ".. tostring(value)
	end
	return true
end

function matchers.should_not_equal(value, expected)
	if _.is_equal(value, expected) then
		return false, "should not be "..tostring(value)
	end
	return true
end
