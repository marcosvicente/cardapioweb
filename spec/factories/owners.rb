# == Schema Information
#
# Table name: owners
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
Faker::Config.locale = 'pt-BR'

FactoryBot.define do
  factory :owner do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
    sequence(:email) { |_n| Faker::Internet.email }
    
  end
end
