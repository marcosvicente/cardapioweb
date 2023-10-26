# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  kind            :integer          default(0)
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
class User < ApplicationRecord
  has_secure_password
  
  enum kind: [:admin, :owner]

  belongs_to :owner, optional: true
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :password_digest, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  validates :owner, presence: true, if: -> { owner? }

  def owner?
    kind == "owner"
  end

  def admin?
    kind == "admin"
  end
end
