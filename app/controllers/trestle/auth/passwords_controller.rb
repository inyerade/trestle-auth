module Trestle
  module Auth
    class PasswordsController < Trestle::ApplicationController
      layout 'trestle/auth'

      skip_before_action :authenticate_user
      skip_before_action :require_authenticated_user

      def new
      end

      def create
        user = Trestle.config.auth.user_scope.find_by(Trestle.config.auth.authenticate_with => params[Trestle.config.auth.authenticate_with])
        if user
          Trestle.config.auth.recover.generate_token.call(user)
          Trestle::Auth::Mailer.password_reset_instructions(user).deliver_now
        end
        flash[:message] = t("admin.auth.passwords.create.success", default: "If your email address exists in our database, you will receive a password recovery link at your email address in a few minutes.")
        redirect_to trestle.login_url
      end

      def edit
        @user = Trestle.config.auth.recover.find_by_token.call(params[:id])
        unless @user
          flash[:error] = t("admin.auth.passwords.edit.error", default: "Password reset link has expired or is invalid.")
          redirect_to trestle.login_url
        end
      end

      def update
        @user = Trestle.config.auth.recover.find_by_token.call(params[:id])
        if @user
          if params[:password].blank?
            flash.now[:error] = t("admin.auth.passwords.update.blank", default: "Password cannot be blank.")
            render :edit
          elsif @user.update(password: params[:password])
            Trestle.config.auth.recover.clear_token.call(@user)
            flash[:message] = t("admin.auth.passwords.update.success", default: "Your password has been changed successfully.")
            redirect_to trestle.login_url
          else
            flash.now[:error] = @user.errors.full_messages.join(", ")
            render :edit
          end
        else
          flash[:error] = t("admin.auth.passwords.edit.error", default: "Password reset link has expired or is invalid.")
          redirect_to trestle.login_url
        end
      end
    end
  end
end
