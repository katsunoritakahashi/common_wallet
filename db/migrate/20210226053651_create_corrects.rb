class CreateCorrects < ActiveRecord::Migration[6.1]
  def change
    create_table :corrects do |t|
      t.string :name
      t.string :palayer
      t.integer :amount
      t.integer :rate
      t.references :user, null: false, foreign_key: true
      t.references :month, null: false, foreign_key: true
      t.references :deposit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
