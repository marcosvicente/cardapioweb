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
class Restaurant < ApplicationRecord
  belongs_to :owner
  
  mount_uploader :logo, LogoUploader

  validates :name, presence: true
  validates :address, presence: true
  validates :logo, presence: true
  validates :opening_hours, presence: true

  after_save :create_lat_long!
  after_update :create_lat_long!

  def create_lat_long!
    GenerateLatLongGoogleMapsWorker.perform_async(self.id)
  end
end
