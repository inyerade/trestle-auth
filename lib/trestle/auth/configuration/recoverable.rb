module Trestle
  module Auth
    class Configuration
      class Recoverable
        include Configurable

        option :enabled, false
        option :for, 1.day

        option :find_by_token, ->(token) {
          scope = Trestle.config.auth.user_scope
          scope.find_by_password_reset_token(token)
        }

        option :generate_token, ->(user) {
          user.generate_password_reset_token!
        }

        option :clear_token, ->(user) {
          user.clear_password_reset_token!
        }
      end
    end
  end
end
