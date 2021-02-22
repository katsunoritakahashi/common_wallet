class CreateMonths < ActiveRecord::Migration[6.1]
  def change
    create_table :months do |t|
      t.date :month
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
