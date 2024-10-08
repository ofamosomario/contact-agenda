# frozen_string_literal: true

# contact scoped
module ContactScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_contact, only: %i[update destroy]

    private

    def set_contact
      @contact = Contact.find(params[:id])
    end
  end
end
