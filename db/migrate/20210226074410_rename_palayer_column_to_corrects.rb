class RenamePalayerColumnToCorrects < ActiveRecord::Migration[6.1]
  def change
    rename_column :corrects, :palayer, :player
  end
end
