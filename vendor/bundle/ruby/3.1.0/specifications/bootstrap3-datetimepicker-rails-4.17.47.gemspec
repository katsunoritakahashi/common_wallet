# -*- encoding: utf-8 -*-
# stub: bootstrap3-datetimepicker-rails 4.17.47 ruby lib

Gem::Specification.new do |s|
  s.name = "bootstrap3-datetimepicker-rails".freeze
  s.version = "4.17.47"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Trevor Strieber".freeze]
  s.date = "2017-03-03"
  s.description = "This gem packages the Bootstrap3 bootstrap-datetimepicker (JS + CSS) for Rails 3.1+ asset pipeline.".freeze
  s.email = ["trevor@strieber.org".freeze]
  s.homepage = "http://github.com/TrevorS/bootstrap3-datetimepicker-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Bootstrap3 bootstrap-datetimepicker's JS + CSS for Rails 3.1+ asset pipeline.".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<momentjs-rails>.freeze, [">= 2.8.1"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<momentjs-rails>.freeze, [">= 2.8.1"])
  end
end
