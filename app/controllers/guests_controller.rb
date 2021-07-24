class GuestsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :authenticated_this_month

  def create
    require 'securerandom'
    user = User.new(name: "ゲストユーザー")
    user.email = SecureRandom.alphanumeric + "@example.com"
    user.password = SecureRandom.alphanumeric
    user.password_confirmation = user.password
    user.save
    log_in(user)
    month_1 = Month.create(user_id: current_user.id, balance: 500000, balance_last: 500000, month: Date.today.beginning_of_month )
    month_2 = Month.create(user_id: current_user.id, balance: rand(10..99) * 10000, balance_last: rand(10..99) * 10000, month: Date.today.ago(1.month).beginning_of_month )
    month_3 = Month.create(user_id: current_user.id, balance: rand(10..99) * 10000, balance_last: rand(10..99) * 10000, month: Date.today.ago(2.month).beginning_of_month )
    month_4 = Month.create(user_id: current_user.id, balance: rand(10..99) * 10000, balance_last: rand(10..99) * 10000, month: Date.today.ago(3.month).beginning_of_month )
    month_5 = Month.create(user_id: current_user.id, balance: rand(10..99) * 10000, balance_last: rand(10..99) * 10000, month: Date.today.ago(4.month).beginning_of_month )
    month_6 = Month.create(user_id: current_user.id, balance: rand(10..99) * 10000, balance_last: rand(10..99) * 10000, month: Date.today.ago(5.month).beginning_of_month )
    month_7 = Month.create(user_id: current_user.id, balance: rand(10..99) * 10000, balance_last: rand(10..99) * 10000, month: Date.today.ago(6.month).beginning_of_month )
    detail_1 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month, classification: 1, spending: rand(100..200) * 10, replayer: "旦那", status: 0,note: "夕食" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(1.day), classification: 2, spending: rand(200..400) * 10, replayer: "嫁", status: 0,note: "洋服代" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(2.day), classification: 3, spending: rand(200..300) * 100, replayer: "旦那", status: 0,note: "旅行代" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(3.day), classification: 1, spending: rand(100..700) * 10, replayer: "共通", status: 1,note: "外食" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(5.day), classification: 1, spending: rand(100..150) * 10, replayer: "嫁", status: 0,note: "夕食" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(7.day), classification: 2, spending: rand(600..1500) * 10, replayer: "共通", status: 1,note: "水道代" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(8.day), classification: 1, spending: rand(350..700) * 10, replayer: "嫁", status: 0,note: "夕食" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(9.day), classification: 0, spending: rand(500..1500) * 100, replayer: "共通", status: 1,note: "家賃" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(10.day), classification: 4, income: 100000, replayer: "旦那", status: 0,note: "定期入金" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(13.day), classification: 1, spending: rand(50..100) * 10, replayer: "旦那", status: 0,note: "昼食" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(15.day), classification: 2, spending: rand(60..150) * 10, replayer: "嫁", status: 0,note: "食器" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(19.day), classification: 4, income: 100000, replayer: "嫁", status: 0,note: "定期入金" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(20.day), classification: 1, spending: rand(100..200) * 10, replayer: "嫁", status: 0,note: "夕食" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(22.day), classification: 2, spending: rand(60..150) * 100, replayer: "共通", status: 1,note: "ガス代" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(23.day), classification: 5, spending: rand(100..200) * 100, replayer: "旦那", status: 0,note: "投資損失" )
    detail_2 = Detail.create(user_id: current_user.id, month_id: month_1.id, date: Date.today.beginning_of_month.since(25.day), classification: 3, spending: rand(100..200) * 100, replayer: "旦那", status: 0,note: "デート" )
    budget = Budget.create(user_id: current_user.id, month_id: month_1.id, rent: 100000, food: 30000, life: 30000, enjoy: 30000, other:10000 )
    deposit = Deposit.create(user_id: current_user.id, month_id: month_1.id, total_deposit: 200000, man_salary: 300000, woman_salary: 250000)
    correct_1 = Correct.create(user_id: current_user.id, month_id: month_1.id, deposit_id: deposit.id, name:"ボーナス", player:"旦那" ,amount: 50000, rate: 90, correct_amount:45000)
    income_total = Detail.where(user_id: current_user.id, month_id: month_1.id).includes(:month).sum(:income)
    spending_total = Detail.where(user_id: current_user.id, month_id: month_1.id).includes(:month).sum(:spending)
    balance_of_payments = income_total - spending_total
    month_1.balance_last = month_1.balance + balance_of_payments
    month_1.save
    redirect_to profile_path, success: 'ゲストユーザーでログインしました'
  end
end
