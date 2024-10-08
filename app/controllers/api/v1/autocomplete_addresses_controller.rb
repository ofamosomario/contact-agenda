# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/autocomplete_controller.rb
    class AutocompleteAddressesController < ApplicationController
      before_action :authenticate_user!

      def index
        service = GooglePlacesService.new
        results = service.autocomplete(params[:input])
        render json: results
      end
    end
  end
end
