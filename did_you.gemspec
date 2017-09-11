Gem::Specification.new do |s|
  s.name     = 'did_you'
  s.version  = '0.0.1'
  s.authors  = ['Victor Shepelev']
  s.email    = 'zverok.offline@gmail.com'
  s.homepage = 'https://github.com/zverok/did_you'

  s.summary = 'Ruby version-agnostic wrapper for did_you_mean gem'
  s.licenses = ['MIT']

  s.required_ruby_version = '>= 2.1.0'

  s.files = `git ls-files`.split($RS).reject do |file|
    file =~ /^(?:
    spec\/.*
    |Gemfile
    |Rakefile
    |\.rspec
    |\.gitignore
    |\.rubocop.yml
    |\.travis.yml
    )$/x
  end
  s.require_paths = ['lib']

  s.add_dependency 'did_you_mean' if RUBY_VERSION < '2.3'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-its'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'kramdown' # for YARD
  s.add_development_dependency 'yard-junk', '>= 0.0.5'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubygems-tasks'
end
