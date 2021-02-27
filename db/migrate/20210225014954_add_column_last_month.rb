class AddColumnLastMonth < ActiveRecord::Migration[6.1]
  def change
    add_column :months, :balance_last, :integer
  end
end
