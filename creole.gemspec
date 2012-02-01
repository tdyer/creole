# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/creole/version'
require 'date'

Gem::Specification.new do |s|
  s.name = 'creole'
  s.version = Creole::VERSION
  s.date = Date.today.to_s

  s.authors = ['Lars Christensen', 'Daniel Mendler', 'Tom Dyer']
  s.email = ['larsch@belunktum.dk', 'mail@daniel-mendler.de', 'tdyer1@gmail.com']
  s.summary = 'Lightweight markup language'
  s.description = 'Creole is a lightweight markup language (http://wikicreole.org/).'
  s.extra_rdoc_files = %w(README.creole)
  s.rubyforge_project = s.name

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w(lib)

  s.homepage = 'http://github.com/tdyer/creole'
  s.rdoc_options = %w(--main README.creole)
  s.add_development_dependency('minitest')
end
