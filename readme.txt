A Lua version of http://documentcloud.github.com/underscore/, see http://mirven.github.com/underscore.lua/ for more information.

Contains three additions to the core underscore.lua: simple_reduce, multi_map and table_iterator.

simple_reduce doesn't require a base case,
it uses the first yield of an iterator passed to it instead.

multi_map can be used on a list of lists of indefinite length,
with a callback given having a number of arguments equal
to the number of iterators in the list of iterators.
This function caters to the iterator with the least amount of yields.

table_iterator is a simple iterator to run through a table,
it yields a key-value pair as a table.
