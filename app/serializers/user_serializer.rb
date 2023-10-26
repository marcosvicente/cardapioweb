class UserSerializer < ActiveModel::Serializer
  attributes :id
  attributes :email
  attributes :first_name
  attributes :kind
  attributes :last_name
  attributes :password_digest
  attributes :username
  attributes :owner_id

  has_one :owner
end
