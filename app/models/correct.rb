class Correct < ApplicationRecord
  belongs_to :user
  belongs_to :month

  validates :name, presence: true
  validates :player, presence: true
  validates :amount, presence: true
  validates :rate, presence: true
  validates :user_id, presence: true
  validates :month_id, presence: true
end
