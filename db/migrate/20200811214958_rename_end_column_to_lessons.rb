class RenameEndColumnToLessons < ActiveRecord::Migration[5.1]
  def change
     rename_column :lessons, :end, :finish
  end
end
