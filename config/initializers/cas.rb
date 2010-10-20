# Load CAS authentication configuration

CAS_CONFIG = YAML.load_file("#{File.dirname(__FILE__)}/../cas.yml")[RAILS_ENV]

if CAS_CONFIG['enabled']
  # Basic CAS client configuration
  require 'casclient'
  require 'casclient/frameworks/rails/filter'

  CASClient::Frameworks::Rails::Filter.configure(
    :cas_base_url => CAS_CONFIG['url'],
    :enable_single_sign_out => true
  )
end
