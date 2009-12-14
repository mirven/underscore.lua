require 'spec_helper'

describe["_.is_empty"] = function()
	it["should return false when the table has elements in it"] = function()
		expect(_.is_empty { 1 }).should_be(false)
		expect(_.is_empty { a=1 }).should_be(false)
	end
	
	it["should return true when the table has no elements in it"] = function()
		expect(_.is_empty {}).should_be(true)
	end
end

spec:report(true)