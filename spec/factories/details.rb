FactoryBot.define do
  factory :detail do
    date { "#{Date.today.beginning_of_month}" }
    note { "買い物" }
    classification { 1 }
    spending { 10000 }
    replayer { "旦那" }
    status { 0 }
  end
end
