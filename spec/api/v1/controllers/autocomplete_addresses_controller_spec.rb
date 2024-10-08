# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AutocompleteAddressesController, type: :request do
  describe 'GET #show' do
    let!(:user) { User.create(email: 'valid_user@gmail.com', password: '123test', password_confirmation: '123test') }
    let(:valid_input) { 'Avenida Paulis' }
    let(:expected_address) { 'Avenida Paulista' }

    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }, as: :json
      @auth_token = response.headers['Authorization']
      allow(GoogleMapsService).to receive(:geocode).with(valid_input).and_return(
        { latitude: -23.561684, longitude: -46.655981, formatted_address: expected_address }
      )
    end

    context 'when the address is valid' do
      it 'returns latitude, longitude, and the correct address' do
        params = { input: valid_input }
        get api_v1_autocomplete_addresses_path(params), headers: { 'Authorization': @auth_token }, as: :json

        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]['description']).to eq('Avenida Paulista - Bela Vista, São Paulo - State of São Paulo, Brazil')
      end
    end
  end
end
