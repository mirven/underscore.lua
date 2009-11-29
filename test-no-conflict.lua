_ = { blah = "blah" }

require 'lib.underscore'

__ = _:no_conflict()

assert(__.functions())
assert(_.blah == "blah")