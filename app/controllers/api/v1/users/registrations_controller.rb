# frozen_string_literal: true

module Api
  module V1
    module Users
      # user registration
      class RegistrationsController < Devise::RegistrationsController
        include RackSessionFix
        respond_to :json

        def create
          build_resource(sign_up_params)
          if resource.save
            sign_in(resource_name, resource)
            render json: {
              status: {
                code: 200, message: 'Signed up successfully.'
              }, data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
            }, status: :ok
          else
            message_request = "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"
            render json: {
              status: { code: 422, message: message_request }
            }, status: :unprocessable_entity
          end
        end

        private

        def respond_with(resource, _opts = {})
          if request.method == 'POST' && resource.persisted?
            render json: {
              status: { code: 200, message: 'Signed up successfully.' },
              data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
            }, status: :ok
          elsif request.method == 'DELETE'
            render json: {
              status: { code: 200, message: 'Account deleted successfully.' }
            }, status: :ok
          else
            message_request = "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"
            render json: {
              status: { code: 422, message: message_request }
            }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
