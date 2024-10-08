# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Authentication::SessionsController, type: :request do
  let!(:user) { User.create(email: 'valid_user@gmail.com', password: '123test', password_confirmation: '123test') }

  describe 'POST #create' do
    context 'when login is successful' do
      it 'returns a successful response with user data' do
        post user_session_path, params: { user: { email: 'valid_user@gmail.com', password: '123test' } }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.headers['Authorization']).to be_present
        expect(response.status).to eq(200)
      end
    end

    context 'when login fails' do
      it 'returns an unauthorized response' do
        post user_session_path, params: { user: { email: 'valid_user@gmail.com', password: 'wrongpassword' } }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logout is successful' do
      it 'returns a successful response' do
        delete destroy_user_session_path
        expect(response).to have_http_status(204)
      end
    end
  end
end
