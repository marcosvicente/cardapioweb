# == Schema Information

class Owner < ApplicationRecord
  has_many :restaurant
  validates :name, presence: true

  def change_owner_restaurant!(restaurant_id, new_owner_id)
    debugger
    restaurant = Restaurant.find(restaurant_id)
    restaurant.update(onwer_id: new_owner_id)
  end
end
