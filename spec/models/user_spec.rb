require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    it "名、メール、パスワードがあれば有効な状態であること" do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it "名がないと無効な状態であること" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "メールアドレスがないと無効な状態であること" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "パスワードがないと無効な状態であること" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("は3文字以上で入力してください")
    end

    it "パスワード確認がないと無効な状態であること" do
      user = FactoryBot.build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("を入力してください")
    end

    # 重複したメールアドレスなら無効な状態であること
    it "is invalid with a duplicate email address" do
      FactoryBot.create(:user, email: "aaron@example.com")
      user = FactoryBot.build(:user, email: "aaron@example.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end
end
