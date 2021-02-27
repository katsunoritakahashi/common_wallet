class Budget < ApplicationRecord
  belongs_to :month
  belongs_to :user
  validates :user_id, presence: true
  validates :month_id, presence: true
end
