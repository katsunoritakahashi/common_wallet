class AddColumnCorrectCorrectAmount < ActiveRecord::Migration[6.1]
  def change
    add_column :corrects, :correct_amount, :integer
  end
end
