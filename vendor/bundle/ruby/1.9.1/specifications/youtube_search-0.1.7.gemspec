# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "youtube_search"
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Grosser"]
  s.date = "2012-10-23"
  s.email = "michael@grosser.it"
  s.homepage = "http://github.com/grosser/youtube_search"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Search youtube via this simple ruby api"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
