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
require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it { is_expected.to belong_to(:owner).class_name('Owner') }

  subject(:restaurant) { build(:restaurant, address: "Boituva") }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }

  describe ".create_lat_long?" do
    context "after_save" do
      let(:restaurant_saved) { create(:restaurant, address: "Boituva") }

      it "should be call a worker" do
        expect(GenerateLatLongGoogleMapsWorker).to have_enqueued_sidekiq_job(restaurant_saved.id)

        expect {
          GenerateLatLongGoogleMapsWorker.perform_async(restaurant_saved.id)
        }.to change(GenerateLatLongGoogleMapsWorker.jobs, :size).by(1)
      end
      
    end

    context "after_update" do
      let!(:new_restaurant) do 
        restaurant_updated = create(:restaurant)
        params = attributes_for(:restaurant, address: "Londrina")
        restaurant_updated.update(params)
        restaurant_updated
      end

      it "should be call a worker" do
        expect(GenerateLatLongGoogleMapsWorker).to have_enqueued_sidekiq_job(new_restaurant.id)
        
        expect {
          GenerateLatLongGoogleMapsWorker.perform_async(new_restaurant.id)
        }.to change(GenerateLatLongGoogleMapsWorker.jobs, :size).by(1)
      end
      
    end
   end
end
