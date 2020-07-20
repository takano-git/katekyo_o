class AddBasicInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tutor, :boolean, default: false
    add_column :users, :parent, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
  end
end
