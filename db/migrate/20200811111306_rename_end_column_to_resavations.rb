class RenameEndColumnToResavations < ActiveRecord::Migration[5.1]
  def change
    rename_column :resavations, :end, :finish
  end
end
