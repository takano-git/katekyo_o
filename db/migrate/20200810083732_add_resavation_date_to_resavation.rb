class AddResavationDateToResavation < ActiveRecord::Migration[5.1]
  def change
    add_column :resavations, :resavation_date, :date
  end
end
