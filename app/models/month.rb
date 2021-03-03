class Month < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :month, presence: true
  validates :balance, presence: true

  has_many :details, dependent: :destroy
  has_one :budget, dependent: :destroy
  has_one :deposit, dependent: :destroy
  has_many :corrects, dependent: :destroy
end
