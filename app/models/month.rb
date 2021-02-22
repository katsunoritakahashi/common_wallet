class Month < ApplicationRecord
  belongs_to :user
  #validates :month, uniqueness: true
end
