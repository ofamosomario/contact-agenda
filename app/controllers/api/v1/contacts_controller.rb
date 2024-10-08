# frozen_string_literal: true

module Api
  module V1
    # app/controllers/api/v1/contacts_controller.rb
    class ContactsController < ApplicationController
      before_action :authenticate_user!
      include ContactScoped

      def index
        contacts = if params[:search].present?
                     current_user
                       .contacts
                       .where('name LIKE ? OR cpf LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
                   else
                     current_user.contacts.all
                   end

        render json: contacts, status: :ok
      end

      def create
        service = Contacts::CreateService.new(contact_params, current_user)
        service.create

        if service.success?
          render json: service.record, status: :created
        else
          render json: { errors: service.errors }, status: :bad_request
        end
      end

      def update
        service = Contacts::UpdateService.new(@contact, contact_params)

        if service.update
          render json: service.record, status: :ok
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        service = Contacts::DestroyService.new(@contact)
        service.destroy

        if service.success?
          render json: { message: 'Contact deleted successfully.' }, status: :ok
        else
          render json: { errors: service.errors }, status: :unprocessable_entity
        end
      end

      private

      def contact_params
        params.require(:contact).permit(:name, :cpf, :phone, :zip_code, :address, :latitude, :longitude)
      end
    end
  end
end
