# == Schema Information
#
# Table name: restaurants
#
#  id            :bigint           not null, primary key
#  address       :string
#  lat           :string
#  logo          :string
#  long          :string
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

  # validate :is_lat_log_filled?

  def is_lat_log_filled?
    if [self.lat, self.long].any?(&:blank?)
      errors.add(:base, "Latitude e Logitude tem que ser preechidos juntos")
    end
  end
end
