# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :request do
  let!(:user) { User.create(email: 'valid_user@gmail.com', password: '123test', password_confirmation: '123test') }
  let!(:contact1) { create(:contact, cpf: '182.065.660-82', user: user) }
  let!(:contact2) { create(:contact, cpf: '495.112.600-14', user: user) }
  let!(:contact3) { create(:contact, cpf: '799.134.290-56', user: user) }

  before do
    post user_session_path, params: { user: { email: user.email, password: user.password } }, as: :json
    @auth_token = response.headers['Authorization']
  end

  describe 'POST #create' do
    context 'when ZIP code is not provided' do
      it 'creates a contact with manual address input' do
        post api_v1_contacts_path,
          params:
          {
            contact: {
              name: 'João Silva',
              cpf: '578.666.460-07',
              phone: '11987654321',
              zip_code: '30455610',
              address: 'Rua das Flores, 123'
            }
          },
          headers: { 'Authorization': @auth_token }
        parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(parsed_response['latitude']).to eq(-19.9675)
        expect(parsed_response['longitude']).to eq(-43.962408)
      end
    end
  end

  describe 'GET #index' do
    context 'when searching by name' do
      it 'returns contacts that match the name' do
        params = { search: contact1.name }
        get api_v1_contacts_path(params), headers: { 'Authorization': @auth_token }, as: :json

        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.map { |c| c['name'] }).to include(contact1.name)
        expect(parsed_response.map { |c| c['name'] }).not_to include(contact2.name, contact3.name)
      end
    end

    context 'when searching by CPF' do
      it 'returns contacts that match the CPF' do
        params = { search: '799.134.290-56' }
        get api_v1_contacts_path(params), headers: { 'Authorization': @auth_token }, as: :json

        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.map { |c| c['cpf'] }).to include(contact3.cpf)
        expect(parsed_response.map { |c| c['cpf'] }).not_to include(contact2.cpf, contact1.cpf)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'updates the requested contact' do
        params = { id: contact1.id, contact: { name: 'Vegeta' } }
        put api_v1_contact_path(params), headers: { 'Authorization': @auth_token }, as: :json
        contact1.reload

        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['name']).to eq('Vegeta')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the contacts exists' do
      it 'deletes the contacts' do
        params = { id: contact1.id }
        expect do
          delete api_v1_contact_path(params), headers: { 'Authorization': @auth_token }, as: :json
        end.to change(Contact, :count).by(-1)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Contact deleted successfully.')
      end
    end
  end
end
