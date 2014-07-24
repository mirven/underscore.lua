require 'spec_helper'

describe["_.sum"] = function()
  it["should return the sum of all elements of the list"] = function()
    input = { 1,2,3 }
    result = _.sum(input)
    expect(result).should_be(6)
  end
end

spec:report(true)
