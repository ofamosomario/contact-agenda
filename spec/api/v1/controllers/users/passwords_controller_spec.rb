# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::PasswordsController, type: :request do
  let!(:user) { User.create(email: 'valid_user@gmail.com', password: '123test', password_confirmation: '123test') }

  before do
    post user_session_path, params: { user: { email: user.email, password: user.password } }, as: :json
    @auth_token = response.headers['Authorization']
  end

  describe 'POST /users/password' do
    it 'sends reset password instructions' do
      post user_password_path, params: { email: 'valid_user@gmail.com' }, as: :json
      expect(response).to have_http_status(:ok)

      expect(response.body).to include('Reset password instructions sent to valid_user@gmail.com')
    end

    it 'returns error for unknown email' do
      post user_password_path, params: { email: 'unknown@example.com' }, as: :json

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Email not found')
    end
  end

  describe 'PUT /users/password' do
    let(:token) { user.send(:set_reset_password_token) }

    it 'resets the password successfully' do
      params = { token: token, user: { password: 'newpassword', password_confirmation: 'newpassword' } }
      put user_password_path(params), headers: { 'Authorization': @auth_token }, as: :json

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Password has been reset successfully')
      expect(user.reload.valid_password?('newpassword')).to be_truthy
    end
  end
end
