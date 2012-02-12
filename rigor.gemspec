Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'rigor'
  s.version     = '0.0.1'
  s.date        = '2012-02-11'
  s.summary     = 'A rigorous A/B testing framework.'
  s.description = ''
  s.license     = 'MIT'

  s.required_ruby_version     = '>= 1.9.2'

  s.author      = 'Paul Rosania'
  s.email       = 'paul.rosania@gmail.com'
  s.homepage    = 'http://github.com/paulrosania/rigor'

  s.files        = Dir['CHANGELOG.md', 'README.rdoc', 'MIT-LICENSE', 'lib/**/*']
  s.require_path = 'lib'
end
