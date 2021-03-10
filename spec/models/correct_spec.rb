require 'rails_helper'

RSpec.describe Correct, type: :model do
  it "全てあれば有効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    deposit = FactoryBot.create(:deposit, user_id: user.id, month_id: month.id)
    correct = FactoryBot.build(:correct)
    correct.month_id = month.id
    correct.user_id = user.id
    correct.deposit_id = deposit.id
    expect(correct).to be_valid
  end

  it "補正名がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    deposit = FactoryBot.create(:deposit, user_id: user.id, month_id: month.id)
    correct = FactoryBot.build(:correct, user_id: user.id, month_id: month.id, deposit_id: deposit.id, name: nil)
    correct.valid?
    expect(correct.errors[:name]).to include("を入力してください")
  end

  it "補正者がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    deposit = FactoryBot.create(:deposit, user_id: user.id, month_id: month.id)
    correct = FactoryBot.build(:correct, user_id: user.id, month_id: month.id, deposit_id: deposit.id, player: nil)
    correct.valid?
    expect(correct.errors[:player]).to include("を入力してください")
  end

  it "合計金額がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    deposit = FactoryBot.create(:deposit, user_id: user.id, month_id: month.id)
    correct = FactoryBot.build(:correct, user_id: user.id, month_id: month.id, deposit_id: deposit.id, amount: nil)
    correct.valid?
    expect(correct.errors[:amount]).to include("を入力してください")
  end

  it "比率がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    deposit = FactoryBot.create(:deposit, user_id: user.id, month_id: month.id)
    correct = FactoryBot.build(:correct, user_id: user.id, month_id: month.id, deposit_id: deposit.id, rate: nil)
    correct.valid?
    expect(correct.errors[:rate]).to include("を入力してください")
  end
end
