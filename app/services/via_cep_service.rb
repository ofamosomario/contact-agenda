# frozen_string_literal: true

# app/services/via_cep_service.rb
class ViaCepService
  include HTTParty
  base_uri 'https://viacep.com.br'

  def self.fetch_address(cep)
    response = get("/ws/#{cep}/json/")
    return response.parsed_response if response.success?

    nil
  end
end
