# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact do
  let!(:user) { User.create(email: 'valid_user@gmail.com', password: '123test', password_confirmation: '123test') }
  
  let(:contact) do
    Contact.new(
      name: 'João Silva',
      cpf: '123.456.789-09',
      phone: '11987654321',
      user: user,
      zip_code: '30455610',
      address: 'Test'
    )
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:zip_code) }

    context 'when CPF is invalid' do
      before { contact.cpf = '12345678901' }

      it 'is not valid' do
        expect(contact).not_to be_valid
        expect(contact.errors[:cpf]).to include('é inválido')
      end

      context 'when CPF is valid' do
        before { contact.cpf = '083.219.216-39' }

        it 'is valid' do
          expect(contact).to be_valid
        end
      end
    end
  end
end
