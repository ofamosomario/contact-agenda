# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/users_controller.rb
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def destroy
        if current_user && params[:id].to_i == current_user.id
          current_user.destroy
          render json: { status: { message: 'User account deleted successfully.' } }, status: :ok
        else
          render json: { error: 'User not found.' }, status: :not_found
        end
      end
    end
  end
end
