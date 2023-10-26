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
class Owner < ApplicationRecord
  has_many :restaurant
  validates :name, presence: true
end
