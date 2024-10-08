# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/addresses_controller.rb
    class AddressesController < ApplicationController
      before_action :authenticate_user!

      def show
        cep = params[:cep]
        address_data = ViaCepService.fetch_address(cep)

        if address_data && address_data['erro'] != true
          render json: address_data, status: :ok
        else
          render json: { error: 'CEP inválido ou não encontrado' }, status: :not_found
        end
      end
    end
  end
end
