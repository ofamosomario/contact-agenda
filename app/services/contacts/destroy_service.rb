# frozen_string_literal: true

module Contacts
  # Service object for deleting Contact records
  class DestroyService
    attr_reader :errors, :record

    def initialize(record)
      @record = record
      @errors = []
      @success = false
    end

    def success?
      @success
    end

    def destroy
      if @record.destroy
        @success = true
        @record = record
      else
        @errors = @record.errors.full_messages
      end
    end
  end
end
