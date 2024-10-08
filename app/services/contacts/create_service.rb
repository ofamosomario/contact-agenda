# frozen_string_literal: true

module Contacts
  # Service object for creating Contact records
  class CreateService
    attr_reader :errors, :record

    def initialize(parameters, user)
      @parameters = parameters
      @user = user

      @errors = []
      @record = nil
      @success = false
    end

    def success?
      @success
    end

    def create
      if @parameters[:zip_code].present?
        address_data = ViaCepService.fetch_address(@parameters[:zip_code])
        address = address_data ? Contact.full_address(address_data) : @parameters[:logradouro]
      end

      geocode_data = GoogleMapsService.geocode(address)

      contact = @user.contacts.new(
        name: @parameters[:name],
        cpf: @parameters[:cpf],
        phone: @parameters[:phone],
        address: address,
        zip_code: @parameters[:zip_code],
        latitude: geocode_data[:latitude],
        longitude: geocode_data[:longitude]
      )
      save_record(contact)
      @record
    end

    def save_record(record)
      record.assign_attributes(@parameters)
      if record.save
        @success = true
        @record = record
      else
        @errors = record.errors.full_messages
      end
    end
  end
end
