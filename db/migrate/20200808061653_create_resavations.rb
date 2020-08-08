class CreateResavations < ActiveRecord::Migration[5.1]
  def change
    create_table :resavations do |t|
      t.datetime :start
      t.datetime :end
      t.integer :tutor_id
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
