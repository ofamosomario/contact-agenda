class UserSerializer
  include JSONAPI::Serializer
  has_many :contacts
  attributes :id, :email, :created_at
end
