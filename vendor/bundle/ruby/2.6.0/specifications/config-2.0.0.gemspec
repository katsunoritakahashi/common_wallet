# -*- encoding: utf-8 -*-
# stub: config 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "config".freeze
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Kuczynski".freeze, "Fred Wu".freeze, "Jacques Crocker".freeze]
  s.date = "2019-06-22"
  s.description = "Easiest way to manage multi-environment settings in any ruby project or framework: Rails, Sinatra, Pandrino and others".freeze
  s.email = ["piotr.kuczynski@gmail.com".freeze, "ifredwu@gmail.com".freeze, "railsjedi@gmail.com".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "CHANGELOG.md".freeze, "LICENSE.md".freeze]
  s.files = ["CHANGELOG.md".freeze, "LICENSE.md".freeze, "README.md".freeze]
  s.homepage = "https://github.com/railsconfig/config".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Effortless multi-environment settings in Rails, Sinatra, Pandrino and others".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 4.2"])
      s.add_runtime_dependency(%q<deep_merge>.freeze, ["~> 1.2", ">= 1.2.1"])
      s.add_runtime_dependency(%q<dry-schema>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 12.0.0", "~> 12.0"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 2.2.0", "~> 2.2"])
      s.add_development_dependency(%q<rails>.freeze, ["~> 5.2", ">= 5.2.2"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 3.7.0", "~> 3.7"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.7", ">= 3.7.2"])
      s.add_development_dependency(%q<test-unit>.freeze, ["~> 3.2", ">= 3.2.7"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3", ">= 1.3.13"])
      s.add_development_dependency(%q<mdl>.freeze, [">= 0.5.0", "~> 0.5"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.62"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 4.2"])
      s.add_dependency(%q<deep_merge>.freeze, ["~> 1.2", ">= 1.2.1"])
      s.add_dependency(%q<dry-schema>.freeze, ["~> 1.0"])
      s.add_dependency(%q<rake>.freeze, [">= 12.0.0", "~> 12.0"])
      s.add_dependency(%q<appraisal>.freeze, [">= 2.2.0", "~> 2.2"])
      s.add_dependency(%q<rails>.freeze, ["~> 5.2", ">= 5.2.2"])
      s.add_dependency(%q<rspec>.freeze, [">= 3.7.0", "~> 3.7"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.7", ">= 3.7.2"])
      s.add_dependency(%q<test-unit>.freeze, ["~> 3.2", ">= 3.2.7"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3", ">= 1.3.13"])
      s.add_dependency(%q<mdl>.freeze, [">= 0.5.0", "~> 0.5"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.62"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 4.2"])
    s.add_dependency(%q<deep_merge>.freeze, ["~> 1.2", ">= 1.2.1"])
    s.add_dependency(%q<dry-schema>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rake>.freeze, [">= 12.0.0", "~> 12.0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 2.2.0", "~> 2.2"])
    s.add_dependency(%q<rails>.freeze, ["~> 5.2", ">= 5.2.2"])
    s.add_dependency(%q<rspec>.freeze, [">= 3.7.0", "~> 3.7"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.7", ">= 3.7.2"])
    s.add_dependency(%q<test-unit>.freeze, ["~> 3.2", ">= 3.2.7"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3", ">= 1.3.13"])
    s.add_dependency(%q<mdl>.freeze, [">= 0.5.0", "~> 0.5"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.62"])
  end
end
