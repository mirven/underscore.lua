require 'spec_helper'

describe["_.zip"] = function()
	describe["*** when providing two lists ***"] = function()
		describe["when both lists are of equal length"] = function()
			before = function()
				left_list = {1, 3, 5}
				right_list = {2, 4, 6}
				result = _.zip(left_list, right_list)
			end
	
			it["should return {{1,2}, {3,4}, {5,6}}"] = function()
				expect( 
					result[1][1] == 1 and
					result[1][2] == 2 and 
					result[2][1] == 3 and 
					result[2][2] == 4 and 
					result[3][1] == 5 and 
					result[3][2] == 6
				).should_be(true)
			end
		end

		describe["when the left list is shorter than the right"] = function()
			before = function()
				left_list = {1, 3, 5}
				right_list = {2, 4, 6, 7}
				result = _.zip(left_list, right_list)
			end
	
			it["\tshould return {{1,2}, {3,4}, {5,6}}"] = function()
				expect( 
					result[1][1] == 1 and
					result[1][2] == 2 and 
					result[2][1] == 3 and 
					result[2][2] == 4 and 
					result[3][1] == 5 and 
					result[3][2] == 6
				).should_be(true)
			end
		end

		describe["when the left list is longer than the right"] = function()
			before = function()
				left_list = {1, 3, 5, 7}
				right_list = {2, 4, 6}
				result = _.zip(left_list, right_list)
			end
	
			it["should return {{1,2}, {3,4}, {5,6}}"] = function()
				expect( 
					result[1][1] == 1 and
					result[1][2] == 2 and 
					result[2][1] == 3 and 
					result[2][2] == 4 and 
					result[3][1] == 5 and 
					result[3][2] == 6
				).should_be(true)
			end
		end
	end

	describe["*** when left is function, right a list ***"] = function()
		describe["when the left function will yield the SAME number of values as the right list"] = function()
			before = function()
				left_func = coroutine.wrap(function()
					for i=1, 5, 2 do 
						coroutine.yield(i)
					end
				end)
				right_list = {2, 4, 6}
				result = _.zip(left_func, right_list)
			end
	
			it["should return {{1,2}, {3,4}, {5,6}}"] = function()
				expect( 
					result[1][1] == 1 and
					result[1][2] == 2 and 
					result[2][1] == 3 and 
					result[2][2] == 4 and 
					result[3][1] == 5 and 
					result[3][2] == 6
				).should_be(true)
			end
		end

		describe["when the left function will yield LESS values as the right list"] = function()
			before = function()
				left_func = coroutine.wrap(function()
					for i=1, 5, 2 do 
						coroutine.yield(i)
					end
				end)
				right_list = {2, 4, 6, 7}
				result = _.zip(left_func, right_list)
			end
	
			it["should return {{1,2}, {3,4}, {5,6}}"] = function()
				expect( 
					result[1][1] == 1 and
					result[1][2] == 2 and 
					result[2][1] == 3 and 
					result[2][2] == 4 and 
					result[3][1] == 5 and 
					result[3][2] == 6
				).should_be(true)
			end
		end

		describe["when the left function will yield MORE values as the right list"] = function()
			before = function()
				left_func = coroutine.wrap(function()
					for i=1, 7, 2 do
						coroutine.yield(i)
					end
				end)
				right_list = {2, 4, 6}
				result = _.zip(left_func, right_list)
			end
	
			it["should return {{1,2}, {3,4}, {5,6}}"] = function()
				expect( 
					result[1][1] == 1 and
					result[1][2] == 2 and 
					result[2][1] == 3 and 
					result[2][2] == 4 and 
					result[3][1] == 5 and 
					result[3][2] == 6
				).should_be(true)
			end
		end
	end	

	describe["*** when right is function, left a list ***"] = function()
		describe["when the right function will yield the same number of values as the left list"] = function()
			before = function()
				local left_list = {1, 3, 5}
				local right_func = coroutine.wrap(function()
					for i=2, 6, 2 do 
						coroutine.yield(i)
					end
				end)	
				result = _.zip(left_list, right_func)
			end
	
			it["should return {{1,2}, {3,4}, {5,6}}"] = function()
				expect( 
					result[1][1] == 1 and
					result[1][2] == 2 and 
					result[2][1] == 3 and 
					result[2][2] == 4 and 
					result[3][1] == 5 and 
					result[3][2] == 6
				).should_be(true)
			end
		end

		describe["when the right function will yield LESS values as the left list"] = function()
			before = function()
				local left_list = {1, 3, 5}
				local right_func = coroutine.wrap(function()
					for i=2, 4, 2 do 
						coroutine.yield(i)
					end
				end)	
				result = _.zip(left_list, right_func)
			end
	
			it["should return {{1,2}, {3,4}}"] = function()
				expect( 
					result[1][1] == 1 and
					result[1][2] == 2 and 
					result[2][1] == 3 and 
					result[2][2] == 4
				).should_be(true)
			end
		end

		describe["when the right function will yield MORE values as the left list"] = function()
			before = function()
				local left_list = {1, 3, 5}
				local right_func = coroutine.wrap(function()
					for i=2,8,2 do 
						coroutine.yield(i)
					end
				end)			
				result = _.zip(left_list, right_func)
			end
	
			it["should return {{1,2}, {3,4}, {5,6}}"] = function()
				expect( 
					result[1][1] == 1 and
					result[1][2] == 2 and 
					result[2][1] == 3 and 
					result[2][2] == 4 and 
					result[3][1] == 5 and 
					result[3][2] == 6
				).should_be(true)
			end
		end
	end								
end


spec:report(true)
