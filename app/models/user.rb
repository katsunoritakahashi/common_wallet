class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  has_many :months, dependent: :destroy
  has_many :details, dependent: :destroy
  has_many :budgets, dependent: :destroy
  has_many :deposits, dependent: :destroy
  has_many :corrects, dependent: :destroy
end
