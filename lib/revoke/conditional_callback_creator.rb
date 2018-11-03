module Revoke
  class ConditionalCallbackCreator

    VALID_CALLBACK_NAME = [:create, :update, :destroy].freeze
    DEFAULT_MESSAGE = 'Operation not allowed'.freeze

    def initialize(class_name, callback_name, options)

      unless callback_name.in?(VALID_CALLBACK_NAME)
        raise ArgumentError, 'Invalid callback name, valid options are create, update and destroy.'
      end

      message = options[:message] || DEFAULT_MESSAGE

      class_name.class_eval do

        send("before_#{callback_name}", :"revoke_#{callback_name}_conditional_handler")

        define_method("revoke_#{callback_name}_conditional_handler") do
          if options[:if].present?
            callable = options[:if]
          elsif options[:unless].present?
            callable = options[:unless]
          else
            raise ArgumentError, 'Invalid argument supplied for revoke.'
          end

          if callable.is_a?(Proc)
            if callable.call
              errors.add(:base, message)
              throw(:abort)
            end
          end

          if callable.is_a?(Symbol)
            if send(callable)
              errors.add(:base, message)
              throw(:abort)
            end
          end
        end

        private :"revoke_#{callback_name}_conditional_handler"
      end
    end

  end
end
