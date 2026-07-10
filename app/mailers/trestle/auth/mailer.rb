module Trestle
  module Auth
    class Mailer < ActionMailer::Base
      def password_reset_instructions(user)
        @user = user
        mail(to: @user.email, subject: I18n.t("admin.auth.mailer.password_reset_instructions.subject", default: "Password Reset Instructions"))
      end
    end
  end
end
