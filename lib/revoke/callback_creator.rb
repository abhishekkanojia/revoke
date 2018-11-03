module Revoke
  class CallbackCreator
    def initialize(class_name, callback_name, event, time, deciding_event, options = {})

      if parameters_valid?(callback_name, event, time, deciding_event)
        error_message = options[:message] if options.present?

        class_name.class_eval do

          send("before_#{callback_name}", :"revoke_#{callback_name}_handler")

          define_method("revoke_#{callback_name}_handler") do

            difference = (Time.current - self.send(Revoke::Constants::ACTION_MAP[deciding_event])).to_i

            if difference.positive? && difference.send(Revoke::Constants::EVENT[event], time)
              errors.add(:base, (error_message || I18n.t(:error, scope: [:revoke, callback_name, :after], class_name: self.class.name, time: send("allowed_time_to_#{callback_name}?"), event: event, deciding_event: deciding_event)))
              throw(:abort)
            end
          end

          define_method("allowed_time_to_#{callback_name}?") do
            parts = ActiveSupport::Duration.build(time.to_i).parts
            ''.tap do |string|
              parts.each_pair do |key, value|
                string.concat("#{value} #{key}")
              end
              string
            end
          end

          private :"revoke_#{callback_name}_handler"
        end
      end
    end

    def parameters_valid?(callback_name, event, time, deciding_event)
      callback_valid?(callback_name) &&
      event_valid?(event) &&
      time_valid?(time) &&
      deciding_event_valid?(deciding_event)
    end

    private def callback_valid?(callback_name)
      if callback_name.in?(Revoke::Constants::ACTION)
        true
      else
        raise_error_message(callback_name, Revoke::Constants::ACTION)
      end
    end

    private def event_valid?(event)
      allowed_event_keys = Revoke::Constants::EVENT.keys
      if event.in?(allowed_event_keys)
        true
      else
        raise_error_message(event, allowed_event_keys)
      end
    end

    private def time_valid?(time)
      if time.is_a?(ActiveSupport::Duration)
        true
      else
        raise ArgumentError, 'Enter duration like: 10.seconds'
      end
    end

    private def deciding_event_valid?(deciding_event)
      allowed_deciding_events = Revoke::Constants::ACTION_MAP.keys
      if deciding_event.in?(allowed_deciding_events)
        true
      else
        raise_error_message(deciding_event, allowed_deciding_events)
      end
    end

    private def raise_error_message(option, allowed_options)
      raise ArgumentError, "Invalid option supplied: #{option}\n Allowed Options: #{allowed_options.join(', ')}"
    end

  end
end
