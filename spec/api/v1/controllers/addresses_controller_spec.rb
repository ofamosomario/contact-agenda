# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AddressesController, type: :request do
  describe 'GET #show' do
    let!(:user) { User.create(email: 'valid_user@gmail.com', password: '123test', password_confirmation: '123test') }
    let(:valid_cep) { '01001-000' }
    let(:invalid_cep) { '00000-000' }

    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }, as: :json
      @auth_token = response.headers['Authorization']

      allow(ViaCepService).to receive(:fetch_address).with(valid_cep).and_return(
        {
          'cep' => valid_cep,
          'logradouro' => 'Praça da Sé',
          'bairro' => 'Sé',
          'localidade' => 'São Paulo',
          'uf' => 'SP'
        }
      )

      allow(ViaCepService).to receive(:fetch_address).with(invalid_cep).and_return(nil)
    end

    context 'when the CEP is valid' do
      it 'returns the address data' do
        params = { cep: valid_cep }
        get api_v1_addresses_path(params), headers: { 'Authorization': @auth_token }, as: :json

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('cep' => valid_cep, 'logradouro' => 'Praça da Sé')
      end
    end

    context 'when the CEP is invalid' do
      it 'returns a not found error' do
        params = { cep: invalid_cep }
        get api_v1_addresses_path(params), headers: { 'Authorization': @auth_token }, as: :json

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to include('error' => 'CEP inválido ou não encontrado')
      end
    end
  end
end
