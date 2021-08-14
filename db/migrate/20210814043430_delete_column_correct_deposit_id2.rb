class DeleteColumnCorrectDepositId2 < ActiveRecord::Migration[6.1]
  def change
    remove_reference :corrects, :deposit
  end
end
