module Trestle
  module Auth
    module ModelMethods
      module Recoverable
        extend ActiveSupport::Concern

        def generate_password_reset_token!
          update(password_reset_token: SecureRandom.urlsafe_base64(15), password_reset_sent_at: Time.current)
        end

        def clear_password_reset_token!
          update(password_reset_token: nil, password_reset_sent_at: nil)
        end

        def password_reset_expired?
          password_reset_sent_at.nil? || Time.current > password_reset_sent_at + Trestle.config.auth.recover.for
        end

        module ClassMethods
          def find_by_password_reset_token(token)
            user = find_by(password_reset_token: token)
            user if user && !user.password_reset_expired?
          end
        end
      end
    end
  end
end
