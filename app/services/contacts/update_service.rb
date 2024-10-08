# frozen_string_literal: true

module Contacts
  # Service object for updating Contact records
  class UpdateService
    attr_reader :errors, :record

    def initialize(record, parameters = {})
      @record = record
      @parameters = parameters
      @errors = []
      @success = false
    end

    def success?
      @success
    end

    def update
      if @record[:zip_code].present?
        address_data = ViaCepService.fetch_address(@record[:zip_code])
        address = address_data ? Contact.full_address(address_data) : @record[:logradouro]
      end

      geocode_data = GoogleMapsService.geocode(address)
      @record[:latitude] = geocode_data[:latitude]
      @record[:longitude] = geocode_data[:longitude]

      update_record(@record)
      @record
    end

    private

    def update_record(record)
      if record.update(@parameters)
        @success = true
        @record = record
      else
        @errors = record.errors.full_messages
      end
    end
  end
end
