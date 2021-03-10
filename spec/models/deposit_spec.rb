require 'rails_helper'

RSpec.describe Deposit, type: :model do
  it "全てあれば有効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    deposit = FactoryBot.build(:deposit)
    deposit.month_id = month.id
    deposit.user_id = user.id
    expect(deposit).to be_valid
  end

  it "合計入金額がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    deposit = FactoryBot.build(:deposit, user_id: user.id, month_id: month.id, total_deposit: nil)
    deposit.valid?
    expect(deposit.errors[:total_deposit]).to include("を入力してください")
  end

  it "旦那給料がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    deposit = FactoryBot.build(:deposit, user_id: user.id, month_id: month.id, man_salary: nil)
    deposit.valid?
    expect(deposit.errors[:man_salary]).to include("を入力してください")
  end

  it "嫁給料がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    deposit = FactoryBot.build(:deposit, user_id: user.id, month_id: month.id, woman_salary: nil)
    deposit.valid?
    expect(deposit.errors[:woman_salary]).to include("を入力してください")
  end
end
