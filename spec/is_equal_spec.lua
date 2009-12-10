require 'luaspec'
_ = require 'underscore'

describe["_.is_equal"] = function()
	describe["when objects are different types"] = function()
		it["should return false"] = function()
			expect(_.is_equal(true, 10)).should_be(false)
			expect(_.is_equal("10", 10)).should_be(false)
		end
	end
	
	describe["when objects are not tables"] = function()
		describe["when items are the same value"] = function()
			it["should return true"] = function()
				expect(_.is_equal(5, 5)).should_be(true)
				expect(_.is_equal(true, true)).should_be(true)
				expect(_.is_equal(false, false)).should_be(true)
				expect(_.is_equal(nil, nil)).should_be(true)
				expect(_.is_equal(3.3, 3.3)).should_be(true)
				expect(_.is_equal("foo", "foo")).should_be(true)
			end
		end
		
		describe["when items are not the same value"] = function()
			it["should return false"] = function()
				expect(_.is_equal(5, 6)).should_be(false)
				expect(_.is_equal(true, false)).should_be(false)
				expect(_.is_equal(3.3, 5.3)).should_be(false)
				expect(_.is_equal("foo", "bar")).should_be(false)
			end
		end
	end
	
	describe["when both objects are tables"] = function()
		describe["when the tables are equivalent"] = function()
			it["should return true"] = function()
				expect(_.is_equal({}, {})).should_be(true)
				expect(_.is_equal({1,2,3}, {1,2,3})).should_be(true)
				expect(_.is_equal({a=1,b=2,c=3}, {a=1,b=2,c=3})).should_be(true)
				expect(_.is_equal({a=1,b=2,c={a=1,b={}}}, {a=1,b=2,c={a=1,b={}}})).should_be(true)
			end
		end
		
		describe["when the tables are not equivalent"] = function()
			it["should return false"] = function()
				expect(_.is_equal({}, {1})).should_be(false)
				expect(_.is_equal({1,2,3}, {1,2,3,4})).should_be(false)
				expect(_.is_equal({a=1,b=2,c=3}, {a=1,b=2,c=3,d=4})).should_be(false)
				expect(_.is_equal({a=1,b=2,c=3,d=4}, {a=1,b=2,c=3})).should_be(false)
				expect(_.is_equal({a=1,b=2,c={a=1,b={}}}, {a=1,b=2,c={a=1,b={1}}})).should_be(false)
			end
		end
		
		describe["when the first table has a __eq metamethod"] = function()
			it["should use the metamethod"] = function()
				mt = { __eq = function(t,u) return true end }
				t1 = setmetatable({}, mt)
				t2 = setmetatable({}, mt)
				
				expect(_.is_equal(t1, t2)).should_be(true)
			end
		end
	end

end


spec:report(true)
