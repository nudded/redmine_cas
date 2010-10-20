require 'casclient'
require 'casclient/frameworks/rails/filter'
require 'application_controller'
require 'dispatcher'

# Patches Redmine's ApplicationController dinamically. Prepends a CAS gatewaying
# filter.
module CasApplicationControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable # Mark as unloadable so it is reloaded in development

      prepend_before_filter :cas_filter, :set_user_id
    end
  end

  module InstanceMethods
    def cas_filter
      if CAS_CONFIG['enabled'] and !['atom', 'xml', 'json'].include?request.format
        if params[:controller] != 'account'
          CASClient::Frameworks::Rails::GatewayFilter.filter(self)
        else
          CASClient::Frameworks::Rails::Filter.filter(self)
        end
      else
        true
      end
    end

    def set_user_id
      if CAS_CONFIG['enabled']
        user = User.find_by_login session[:cas_user]
        if user and session[:user_id] != user.id
          session[:user_id] = user.id
          call_hook(:controller_account_success_authentication_after, {:user => user })
        end
      end
      true
    end
  end
end

Dispatcher.to_prepare do
  ApplicationController.send(:include, CasApplicationControllerPatch)
end
