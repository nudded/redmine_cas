# Patches Redmine's Setting dinamically. Disables self registration link.
module CAS
  module SettingPatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)

      base.class_eval do
        unloadable # Mark as unloadable so it is reloaded in development

        class << self
          alias_method_chain :self_registration?, :cas
        end
      end
    end

    module ClassMethods
      def self_registration_with_cas?
        CAS::CONFIG['enabled'] ? false : self_registration_without_cas?
      end
    end
  end
end

require_dependency 'setting'
Setting.send(:include, CAS::SettingPatch)
