# frozen_string_literal: true

# app/models/contact.rb
class Contact < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: { case_sensitive: false, scope: :user_id } # Ensure uniqueness scoped to user_id
  validates :phone, presence: true
  validates :address, presence: true
  validates :zip_code, presence: true

  validate :valid_cpf

  def self.full_address(address)
    "#{address['logradouro']}, #{address['bairro']}, #{address['estado']}, #{address['uf']}"
  end

  private

  def valid_cpf
    return if cpf.blank?

    unless CPF.valid?(cpf)
      errors.add(:cpf, 'é inválido')
    end
  end
end
