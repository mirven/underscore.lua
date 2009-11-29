_ = { blah = "blah" }

require 'lib.underscore'

__ = _:no_conflict()

print(unpack(__.functions()))

assert(_.blah == "blah")