require "revoke/version"
require "revoke/constants"
require "revoke/callback_creator"
require "revoke/conditional_callback_creator"
require "revoke/engine" if defined?(Rails)

module Revoke

  include Constants

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def revoke(*args)
      if args.size.eql?(2)
        Revoke::ConditionalCallbackCreator.new(self, args[0], args[1])
      else
        Revoke::CallbackCreator.new(self, args[0], args[1], args[2], args[3], args[4])
      end
    end

  end
end

ActiveRecord::Base.send :include, Revoke if defined?(Rails)
