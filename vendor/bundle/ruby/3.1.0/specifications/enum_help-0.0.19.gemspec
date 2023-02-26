# -*- encoding: utf-8 -*-
# stub: enum_help 0.0.19 ruby lib

Gem::Specification.new do |s|
  s.name = "enum_help".freeze
  s.version = "0.0.19"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Lester Zhao".freeze]
  s.date = "2022-04-27"
  s.description = " Help ActiveRecord::Enum feature to work fine with I18n and simple_form.  ".freeze
  s.email = ["zm.backer@gmail.com".freeze]
  s.homepage = "https://github.com/zmbacker/enum_help".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Extends of ActiveRecord::Enum, which can used in simple_form and internationalization".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
  end
end
