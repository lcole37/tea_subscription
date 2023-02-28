class Subscription < ApplicationRecord
  validates :title, :status, :frequency, presence: true
  validates :price, presence: true, numericality: true

  enum status: { active: 0, inactive: 1 }
  enum frequency: { once: 0, weekly: 1, monthly: 2, quarterly: 3 }
  
  belongs_to :tea
  belongs_to :customer
end
