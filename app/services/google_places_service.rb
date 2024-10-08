# frozen_string_literal: true

# app/services/via_cep_service.rb
class GooglePlacesService
  include HTTParty
  base_uri 'https://maps.googleapis.com/maps/api/place/autocomplete'

  def autocomplete(input)
    response = self.class.get('/json', query: { input: input, key: ENV['GOOGLE_MAPS_API_KEY'] })

    if response.success?
      response.parsed_response['predictions']
    else
      []
    end
  end
end
