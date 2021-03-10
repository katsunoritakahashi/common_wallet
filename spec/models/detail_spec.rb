require 'rails_helper'

RSpec.describe Detail, type: :model do
  it "全てあれば有効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    detail = FactoryBot.build(:detail)
    detail.month_id = month.id
    detail.user_id = user.id
    expect(detail).to be_valid
  end

  it "日付がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    detail = FactoryBot.build(:detail, user_id: user.id, month_id: month.id, date: nil)
    detail.valid?
    expect(detail.errors[:date]).to include("を入力してください")
  end

  it "立替がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    detail = FactoryBot.build(:detail, user_id: user.id, month_id: month.id, replayer: nil)
    detail.valid?
    expect(detail.errors[:replayer]).to include("を入力してください")
  end

  it "状態がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    detail = FactoryBot.build(:detail, user_id: user.id, month_id: month.id, status: nil)
    detail.valid?
    expect(detail.errors[:status]).to include("を入力してください")
  end

  it "項目がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    detail = FactoryBot.build(:detail, user_id: user.id, month_id: month.id, classification: nil)
    detail.valid?
    expect(detail.errors[:classification]).to include("を入力してください")
  end

  it "メモが10文字以内でないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    detail = FactoryBot.build(:detail, user_id: user.id, month_id: month.id, note: "aiueokakikukekosa")
    detail.valid?
    expect(detail.errors[:note]).to include("は10文字以内で入力してください")
  end
end
