# frozen_string_literal: true

# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers

  def current_user
    @current_user ||= User.find_by(id: decoded_token['sub']) if decoded_token
  end

  private

  def decoded_token
    token = request.headers['Authorization']&.split(' ')&.last
    return unless token

    begin
      JWT.decode(token, ENV['JWT_DECODE_KEY'])[0]
    rescue JWT::DecodeError
      nil
    end
  end
end
