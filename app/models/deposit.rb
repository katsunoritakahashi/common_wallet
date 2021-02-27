class Deposit < ApplicationRecord
  belongs_to :user
  belongs_to :month
  has_many :corrects, dependent: :destroy

  validates :total_deposit, presence: true
  validates :man_salary, presence: true
  validates :woman_salary, presence: true
  validates :user_id, presence: true
  validates :month_id, presence: true
end
