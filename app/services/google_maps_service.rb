# frozen_string_literal: true

# app/services/google_maps_service.rb
class GoogleMapsService
  include HTTParty
  base_uri 'https://maps.googleapis.com/maps/api'

  def self.geocode(address)
    response = get('/geocode/json', query: { address: address, key: ENV['GOOGLE_MAPS_API_KEY'] })
    if response.success? && response['status'] == 'OK'
      result = response['results'].first
      {
        latitude: result['geometry']['location']['lat'],
        longitude: result['geometry']['location']['lng']
      }
    else
      { error: response['status'] }
    end
  end
end
