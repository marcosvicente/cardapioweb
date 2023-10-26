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
FactoryBot.define do
  arquivo_teste = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample.jpg'), 'image/png')

  factory :restaurant do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
    opening_hours { "9h as 20h" }
    logo { arquivo_teste }

    lat { "" }
    long { "" }
    owner { create(:owner) }

    trait :with_lat_long do
      lat { Faker::Address.latitude }
      long { Faker::Address.longitude }
    end
  end
end
