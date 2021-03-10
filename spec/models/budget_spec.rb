require 'rails_helper'

RSpec.describe Budget, type: :model do
  it "全てあれば有効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    budget = FactoryBot.build(:budget)
    budget.month_id = month.id
    budget.user_id = user.id
    expect(budget).to be_valid
  end

  it "家賃がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    budget = FactoryBot.build(:budget, user_id: user.id, month_id: month.id, rent: nil)
    budget.valid?
    expect(budget.errors[:rent]).to include("を入力してください")
  end

  it "生活費がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    budget = FactoryBot.build(:budget, user_id: user.id, month_id: month.id, life: nil)
    budget.valid?
    expect(budget.errors[:life]).to include("を入力してください")
  end

  it "食費がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    budget = FactoryBot.build(:budget, user_id: user.id, month_id: month.id, food: nil)
    budget.valid?
    expect(budget.errors[:food]).to include("を入力してください")
  end

  it "交際費がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    budget = FactoryBot.build(:budget, user_id: user.id, month_id: month.id, enjoy: nil)
    budget.valid?
    expect(budget.errors[:enjoy]).to include("を入力してください")
  end

  it "その他がないと無効な状態であること" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    budget = FactoryBot.build(:budget, user_id: user.id, month_id: month.id, other: nil)
    budget.valid?
    expect(budget.errors[:other]).to include("を入力してください")
  end

end
