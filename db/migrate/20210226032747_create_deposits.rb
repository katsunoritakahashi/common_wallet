class CreateDeposits < ActiveRecord::Migration[6.1]
  def change
    create_table :deposits do |t|
      t.integer :total_deposit
      t.integer :man_salary
      t.integer :woman_salary
      t.references :user, null: false, foreign_key: true
      t.references :month, null: false, foreign_key: true

      t.timestamps
    end
  end
end
