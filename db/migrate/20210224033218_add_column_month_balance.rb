class AddColumnMonthBalance < ActiveRecord::Migration[6.1]
  def change
    add_column :months, :balance, :integer
  end
end
