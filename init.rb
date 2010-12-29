# Run initializers
# Needs to be atop requires because some of them need to be run after initialization
Dir["#{File.dirname(__FILE__)}/config/initializers/**/*.rb"].sort.each do |initializer|
  require initializer
end

require 'redmine'
require 'cas/account_controller_patch'
require 'cas/application_controller_patch'
require 'cas/user_patch'

Redmine::Plugin.register :redmine_cas do
  name 'CAS Web Authentication'
  author 'José M. Prieto (Emergya)'
  description 'CAS single sign-on authentication via CAS web interface'
  version '1.0'
  requires_redmine :version_or_higher => '0.9.0'
  url 'http://gitorious.org/redmine_cas'
  author_url 'http://www.emergya.es'
end
