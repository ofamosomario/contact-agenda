class ContactSerializer
  include JSONAPI::Serializer
  attributes :name, :cpf, :phone, :zip_code, :address, :latitude, :longitude, :full_address

  def full_address
    "#{address} - #{zip_code}"
  end
end
