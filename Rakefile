require 'rubygems'
require 'haml'
require 'yaml'

desc "Creates the html documentation"  
task :doc do
  template = File.read('template/index.haml')
  engine = Haml::Engine.new(template)
  input = YAML.load_file("template/functions.yaml")
  out = engine.render(Object.new, input)

  File.open("docs/index.html", "w") { |file| file.write(out) }
end


namespace :rock do
  version = "0.3-0"
  rocks_home = "/Users/mirven/Projects"

  desc "Uploads the current copy of the code to my rockserver"      
  task :default => [:rockspec, :package, :release] do
  end

  task :rockspec do
    `sed  s/\\$version/#{version}/ < template/underscore.lua.rockspec > out/underscore.lua-#{version}.rockspec`
  end
  
  task :package do
    `git archive --format=zip --prefix underscore.lua-#{version}/ master >out/underscore.lua-#{version}.zip`
  end
  
  task :release do
    `cp out/underscore.lua-#{version}.rockspec #{rocks_home}`
    `cp out/underscore.lua-#{version}.zip #{rocks_home}`
    Dir.chdir rocks_home do
      puts `luarocks-admin  make_manifest luarocks`
      puts `s3sync -r luarocks/ marcusirven:rocks --public-read`
    end
    
    `git tag -a -m "tagging version #{version}" #{version}`
    `git push origin --tags`
    
  end
end

desc "Updates http://mirven.github.com/underscore.lua"
task :pages => :doc do
  `cp -r docs docs.tmp`
  `git checkout gh-pages`
  `cp -r docs.tmp/* .`
  `rm -rf docs.tmp`
  `git add css`
  `git add *.html`
  `git commit -m "update pages"`
  `git push origin gh-pages`
  `git checkout master`
end