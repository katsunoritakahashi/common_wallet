class RemoveColumnDeposit < ActiveRecord::Migration[6.1]
  def change
    remove_column :deposits, :correction1_name, :string
    remove_column :deposits, :correction1_amount, :integer
    remove_column :deposits, :correction1_rate, :integer
    remove_column :deposits, :correction2_name, :string
    remove_column :deposits, :correction2_amount, :integer
    remove_column :deposits, :correction2_rate, :integer
    remove_column :deposits, :correction3_name, :string
    remove_column :deposits, :correction3_amount, :integer
    remove_column :deposits, :correction3_rate, :integer
  end
end
