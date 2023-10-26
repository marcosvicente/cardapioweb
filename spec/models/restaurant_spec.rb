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
require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it { is_expected.to belong_to(:owner).class_name('Owner') }

  subject(:restaurant) { build(:restaurant) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }

  describe ".is_lat_log_filled?" do
   xit "should be return error when lat filled e long not filled" do
      restaurant.lat = Faker::Address.latitude

      expect(restaurant).to be_invalid
      expect(restaurant.errors.full_messages).to include("Latitude e Logitude tem que ser preechidos juntos")
    end

    xit "should be return error when lat not filled e long filled" do
      restaurant.long = Faker::Address.longitude

      expect(restaurant).to be_invalid
      expect(restaurant.errors.full_messages).to include("Latitude e Logitude tem que ser preechidos juntos")
    end

    xit "should be return success when lat filled e long not filled" do
      restaurant.lat = Faker::Address.latitude
      restaurant.long = Faker::Address.longitude

      expect(restaurant).to be_valid
    end
  end
end
