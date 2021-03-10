FactoryBot.define do
  factory :month do
    month { "#{Date.today.beginning_of_month}" }
    balance { "100000" }
    balance_last { "100000" }
  end
end
