class DeleteColumnCorrectDepositId < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :corrects, :deposits
    remove_index :corrects, :deposit_id
  end
end
