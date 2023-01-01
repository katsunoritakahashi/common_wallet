class Budget < ApplicationRecord
  belongs_to :month
  belongs_to :user
  validates :user_id, presence: true
  validates :month_id, presence: true
  validates :life, presence: true
  validates :rent, presence: true
  validates :food, presence: true
  validates :enjoy, presence: true
  validates :child, presence: true
  validates :other, presence: true
end
