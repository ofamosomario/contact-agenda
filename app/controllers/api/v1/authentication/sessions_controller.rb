
# frozen_string_literal: true

module Api
  module V1
    module Authentication
      # session
      class SessionsController < Devise::SessionsController
        include RackSessionFix

        private

        def respond_with(resource, _opts = {})
          render json: {
            status: { code: :ok, message: 'Logged in successfully.' },
            data: UserSerializer.new(resource)
          }, status: :ok
        end

        def respond_to_on_destroy
          head :no_content
        end
      end
    end
  end
end
