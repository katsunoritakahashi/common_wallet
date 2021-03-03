class CreateDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :details do |t|
      t.date :date
      t.integer :classification
      t.integer :income
      t.integer :spending
      t.string :replayer
      t.integer :status
      t.string :note
      t.references :month, null: false, foreign_key: true

      t.timestamps
    end
  end
end
