require 'spec_helper'

describe["_.values"] = function()
	it["should return an array with all property values"] = function()
		input = { a = 1, b = 2, c = 3 }
		values = _.values(input)
		
		expect(#values).should_be(3)
		expect(_.include(values, 1)).should_be(true)
		expect(_.include(values, 2)).should_be(true)
		expect(_.include(values, 3)).should_be(true)
	end
end

spec:report(true)