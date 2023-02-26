# -*- encoding: utf-8 -*-
# stub: oauth 0.6.2 ruby lib

Gem::Specification.new do |s|
  s.name = "oauth".freeze
  s.version = "0.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/oauth-xx/oauth-ruby/issues", "changelog_uri" => "https://github.com/oauth-xx/oauth-ruby/blob/v0.6.2/CHANGELOG.md", "documentation_uri" => "https://www.rubydoc.info/gems/oauth/0.6.2", "homepage_uri" => "https://github.com/oauth-xx/oauth-ruby", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/oauth-xx/oauth-ruby/tree/v0.6.2", "wiki_uri" => "https://github.com/oauth-xx/oauth-ruby/wiki" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pelle Braendgaard".freeze, "Blaine Cook".freeze, "Larry Halff".freeze, "Jesse Clark".freeze, "Jon Crosby".freeze, "Seth Fitzsimmons".freeze, "Matt Sanford".freeze, "Aaron Quint".freeze, "Peter Boling".freeze]
  s.date = "2022-08-29"
  s.email = "oauth-ruby@googlegroups.com".freeze
  s.executables = ["oauth".freeze]
  s.extra_rdoc_files = ["TODO".freeze]
  s.files = ["TODO".freeze, "bin/oauth".freeze]
  s.homepage = "https://github.com/oauth-xx/oauth-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "\nYou have installed oauth version 0.6.2, congratulations!\n\nNon-commercial support for the 0.6.x series will end by April, 2024. Please upgrade to 1.0.x as soon as possible!\nThe only breaking change will be dropped support for Ruby 2.4, 2.5, and 2.6.\n\nPlease see:\n\u2022 https://github.com/oauth-xx/oauth-ruby/blob/main/SECURITY.md\n\nNote also that I am, and this project is, in the process of leaving Github.\nI wrote about some of the reasons here:\n\u2022 https://dev.to/galtzo/im-leaving-github-50ba\n\nIf you are a human, please consider a donation as I move toward supporting myself with Open Source work:\n\u2022 https://liberapay.com/pboling\n\u2022 https://ko-fi.com/pboling\n\u2022 https://patreon.com/galtzo\n\nIf you are a corporation, please consider supporting this project, and open source work generally, with a TideLift subscription.\n\u2022 https://tidelift.com/funding/github/rubygems/oauth\n\u2022 Or hire me. I am looking for a job!\n\nPlease report issues, and support the project!\n\nThanks, |7eter l-|. l3oling\n".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.3.7".freeze
  s.summary = "OAuth Core Ruby implementation".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<snaky_hash>.freeze, ["~> 2.0"])
    s.add_runtime_dependency(%q<version_gem>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<em-http-request>.freeze, ["~> 1.1.7"])
    s.add_development_dependency(%q<iconv>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.15.0"])
    s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_development_dependency(%q<rack>.freeze, ["~> 2.0"])
    s.add_development_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_development_dependency(%q<rest-client>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop-lts>.freeze, ["~> 12.0"])
    s.add_development_dependency(%q<typhoeus>.freeze, [">= 0.1.13"])
    s.add_development_dependency(%q<webmock>.freeze, ["<= 3.14.0"])
  else
    s.add_dependency(%q<snaky_hash>.freeze, ["~> 2.0"])
    s.add_dependency(%q<version_gem>.freeze, ["~> 1.1"])
    s.add_dependency(%q<em-http-request>.freeze, ["~> 1.1.7"])
    s.add_dependency(%q<iconv>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.15.0"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_dependency(%q<rack>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rest-client>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop-lts>.freeze, ["~> 12.0"])
    s.add_dependency(%q<typhoeus>.freeze, [">= 0.1.13"])
    s.add_dependency(%q<webmock>.freeze, ["<= 3.14.0"])
  end
end
