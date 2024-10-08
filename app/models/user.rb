# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, :recoverable, jwt_revocation_strategy: self

  has_many :contacts, dependent: :destroy

  def generate_jwt
    JWT.encode({ id: id, exp: 60.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  def send_reset_password_instructions
    raw_token, hashed_token = Devise.token_generator.generate(self.class, :reset_password_token)
    self.reset_password_token = hashed_token
    self.reset_password_sent_at = Time.now.utc
    save!
    PasswordMailer.with(user: self, token: raw_token).reset_password_email.deliver_later
  end
end
