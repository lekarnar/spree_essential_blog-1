$:.push File.expand_path("../lib", __FILE__)
require "spree_essential_blog/version"

Gem::Specification.new do |s|

  s.name        = "spree_essential_blog"
  s.version     = SpreeEssentialBlog::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/spree_essential_blog"
  s.summary     = %q{Spree Essential Blog is a blog plugin for Spree sites equipped with spree_essentials.}
  s.description = %q{Spree Essential Blog is a blog plugin for Spree sites equipped with spree_essentials.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.require_paths = ["lib"]

  # s.add_runtime_dependency('spree_essentials')
  s.add_runtime_dependency('acts-as-taggable-on')
  s.add_dependency 'simple_form'

  s.add_development_dependency('shoulda')
  s.add_development_dependency('dummier')
  s.add_development_dependency('factory_girl')
  s.add_development_dependency('capybara')
  s.add_development_dependency('sqlite3')
  s.add_development_dependency('simplecov')
  # s.add_development_dependency('turn',         '~> 0.9.3')

end
