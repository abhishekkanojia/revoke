module Revoke
  class CallbackCreator
    def initialize(class_name, callback_name, event, time, deciding_event)
      class_name.class_eval do

        send("before_#{callback_name}", :"revoke_#{callback_name}_handler")

        define_method("revoke_#{callback_name}_handler") do

          difference = (Time.current - self.send(Revoke::Constants::ACTION_MAP[deciding_event])).to_i

          if difference.positive? && difference.send(Revoke::Constants::EVENT[event], time)
            errors.add(:base, I18n.t(:error, scope: [:revoke, callback_name, :after], class_name: self.class.name, time: send("allowed_time_to_#{callback_name}?"), event: event, deciding_event: deciding_event))
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
end
