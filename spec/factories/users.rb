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
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.last_name }
    username { Faker::Name.name }
    sequence(:email) { |_n| Faker::Internet.email }
    password { '123456' }
    kind { :admin }

    trait :with_owner do
      kind { :owner }
      association :owner, factory: [:owner]
    end
  end
end
