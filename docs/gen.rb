require 'rubygems'
require 'haml'
require 'yaml'


template = File.read('index.haml')

engine = Haml::Engine.new(template)

input = YAML.load_file("functions.yaml")

out = engine.render(Object.new, input)

File.open("out.html", "w") { |file| file.write(out) }
