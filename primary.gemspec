$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "primary/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "primary"
  s.version     = Primary::VERSION
  s.authors     = ["Maciej Litwiniuk"]
  s.email       = ["maciej@litwiniuk.net"]
  s.homepage    = "https://github.com/prograils/primary"
  s.summary     = "Simple gem that will help with primary/default records"
  s.description = "This simple gem will help you with keeping default or primary record (one record that is marked as primary) - ie. default domain or language for site"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl"
end
