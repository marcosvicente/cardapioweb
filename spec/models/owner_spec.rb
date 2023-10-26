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
require 'rails_helper'

RSpec.describe Owner, type: :model do
  it { is_expected.to have_many(:restaurant).class_name('Restaurant') }
  
  subject(:owner) { build(:owner) }
  it { is_expected.to validate_presence_of(:name) }
end
