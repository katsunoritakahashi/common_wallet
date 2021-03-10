require 'rails_helper'

RSpec.describe Month, type: :model do
  describe Month do
    it "月、月初残高、user_idがあれば有効な状態であること" do
      user = FactoryBot.create(:user)
      month = FactoryBot.build(:month)
      month.user_id = user.id
      expect(month).to be_valid
    end

    it "月がないと無効な状態であること" do
      user = FactoryBot.create(:user)
      month = FactoryBot.build(:month, month: nil)
      month.user_id = user.id
      month.valid?
      expect(month.errors[:month]).to include("を入力してください")
    end

    it "月初残高がないと無効な状態であること" do
      user = FactoryBot.create(:user)
      month = FactoryBot.build(:month, balance: nil)
      month.user_id = user.id
      month.valid?
      expect(month.errors[:balance]).to include("を入力してください")
    end

    it "User_idがないと無効な状態であること" do
      month = FactoryBot.build(:month)
      month.valid?
      expect(month.errors[:user_id]).to include("を入力してください")
    end 
  end
end
