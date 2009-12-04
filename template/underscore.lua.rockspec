package = "underscore.lua"
version = "$version"
source = {
	url = "http://marcusirven.s3.amazonaws.com/rocks/"..package.."-"..version..".zip"
}
description = {
	summary = "An utility library adding functional programming support",
	detailed = [[
		An utility library adding functional programming support
	]],
	homepage = "http://mirven.github.com/underscore.lua/", 
	license = "MIT/X11" -- same a Lua
}
dependencies = {
	"lua >= 5.1"
}
build = {
	type = "builtin";
	modules = {
		underscore = 'lib/underscore.lua';
	}
}
