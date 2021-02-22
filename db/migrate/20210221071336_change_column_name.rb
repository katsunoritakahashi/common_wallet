class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_table :User, :users
  end
end
