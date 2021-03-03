class AddColumnDeposit < ActiveRecord::Migration[6.1]
  def change
    add_column :deposits, :correction1_name, :string
    add_column :deposits, :correction1_amount, :integer
    add_column :deposits, :correction1_rate, :integer
    add_column :deposits, :correction2_name, :string
    add_column :deposits, :correction2_amount, :integer
    add_column :deposits, :correction2_rate, :integer
    add_column :deposits, :correction3_name, :string
    add_column :deposits, :correction3_amount, :integer
    add_column :deposits, :correction3_rate, :integer
  end
end
