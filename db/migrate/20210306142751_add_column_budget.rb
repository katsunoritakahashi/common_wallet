class AddColumnBudget < ActiveRecord::Migration[6.1]
  def change
    add_column :budgets, :other, :integer
  end
end
