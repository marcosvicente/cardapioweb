# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  kind            :integer          default("admin")
#  last_name       :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  owner_id        :bigint
#
# Indexes
#
#  index_users_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => owners.id)
#
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
