# Run initializers
# Needs to be atop requires because some of them need to be run after initialization
Dir["#{File.dirname(__FILE__)}/config/initializers/**/*.rb"].sort.each do |initializer|
  require initializer
end

require 'redmine'
require 'cas_account_controller_patch'
require 'cas_application_controller_patch'

Redmine::Plugin.register :redmine_cas do
  name 'CAS Web Authentication'
  author 'José M. Prieto (Emergya)'
  description 'CAS single sign-on authentication via CAS web interface'
  version '0.1'
  #TODO url 'http://example.com/path/to/plugin'
  author_url 'http://www.emergya.es'
end
