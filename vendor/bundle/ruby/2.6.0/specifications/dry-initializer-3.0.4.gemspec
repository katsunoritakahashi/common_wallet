# -*- encoding: utf-8 -*-
# stub: dry-initializer 3.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "dry-initializer".freeze
  s.version = "3.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org", "bug_tracker_uri" => "https://github.com/dry-rb/dry-initializer/issues", "changelog_uri" => "https://github.com/dry-rb/dry-initializer/blob/master/CHANGELOG.md", "source_code_uri" => "https://github.com/dry-rb/dry-initializer" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Vladimir Kochnev (marshall-lee)".freeze, "Andrew Kozin (nepalez)".freeze]
  s.date = "2020-09-29"
  s.description = "DSL for declaring params and options of the initializer".freeze
  s.email = ["andrew.kozin@gmail.com".freeze]
  s.homepage = "https://dry-rb.org/gems/dry-initializer".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "DSL for declaring params and options of the initializer".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
