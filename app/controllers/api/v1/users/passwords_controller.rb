# frozen_string_literal: true

module Api
  module V1
    module Users
      # recover password
      class PasswordsController < Devise::RegistrationsController
        include RackSessionFix

        def create
          user = User.find_by(email: params[:email])

          if user
            user.send_reset_password_instructions
            render json: { message: "Reset password instructions sent to #{user.email}" }, status: :ok
          else
            render json: { error: 'Email not found' }, status: :not_found
          end
        end

        def update
          if current_user.update(user_params)
            render json: { message: 'Password has been reset successfully' }, status: :ok
          else
            render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.require(:user).permit(:password, :password_confirmation)
        end
      end
    end
  end
end
