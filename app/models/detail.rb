class Detail < ApplicationRecord
  belongs_to :month
  belongs_to :user

  validates :date, presence: true
  validates :user_id, presence: true
  validates :month_id, presence: true
  validates :status, presence: true
  validates :classification, presence: true
  validates :note, length: { maximum: 10 }
  enum classification: { rent: 0, food: 1, life: 2, enjoy: 3, money: 4 }
  enum status: { not_yet: 0, done: 1 }
end
