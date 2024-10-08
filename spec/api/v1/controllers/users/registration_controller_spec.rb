# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::RegistrationsController, type: :request do
  let!(:user) { User.create(email: 'valid_user@gmail.com', password: '123test', password_confirmation: '123test') }

  describe 'POST #create' do
    context 'when the user is created successfully' do
      let(:user_params) do
        {
          user: {
            email: 'test@example.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'returns a successful response' do
        post user_registration_path, params: user_params, as: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']['message']).to eq('Signed up successfully.')
      end
    end

    context 'when the user creation fails' do
      let(:invalid_user_params) do
        {
          user: {
            email: 'invalid@user.com',
            password: '123',
            password_confirmation: '1234'
          }
        }
      end

      it 'returns an error response' do
        post user_registration_path, params: invalid_user_params, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['status']['message']).to match(/User couldn't be created successfully/)
      end
    end
  end
end
