# == Schema Information
#
# Table name: restaurants
#
#  id            :bigint           not null, primary key
#  address       :string
#  lat           :float
#  logo          :string
#  long          :float
#  name          :string
#  opening_hours :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  owner_id      :bigint           not null
#
# Indexes
#
#  index_restaurants_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => owners.id)
#
class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :lat, :long, :opening_hours, :logo, :owner_id
  has_one :owner
end
