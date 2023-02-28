class Customer < ApplicationRecord
  validates :first_name, :last_name, :address, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_many :subscriptions
  has_many :teas, through: :subscriptions
end
