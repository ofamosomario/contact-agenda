# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users, type: :request do
  let!(:user) { User.create(email: 'valid_user@gmail.com', password: '123test', password_confirmation: '123test') }
  let!(:contact1) { create(:contact, cpf: '182.065.660-82', user: user) }
  let!(:contact2) { create(:contact, cpf: '495.112.600-14', user: user) }

  before do
    post user_session_path, params: { user: { email: user.email, password: user.password } }, as: :json
    @auth_token = response.headers['Authorization']
  end

  describe 'DELETE #destroy' do
    it 'deletes the user account' do
      delete api_v1_user_path(user.id), headers: { 'Authorization': @auth_token }, as: :json

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['status']['message']).to eq('User account deleted successfully.')
      expect(User.find_by(email: 'valid_user@gmail.com')).to be_nil
      expect(Contact.where(user_id: user.id)).to be_empty
    end

    it 'return an error if the user is not the current user' do
      delete api_v1_user_path(10), headers: { 'Authorization': @auth_token }, as: :json

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('User not found.')
    end
  end
end
