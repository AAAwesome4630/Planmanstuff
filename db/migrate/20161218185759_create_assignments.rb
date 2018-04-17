class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.date :due_date
      t.string :name
      t.integer :classroom_id
      t.integer :rec_days
      t.integer :eta
      t.string :description

      t.timestamps null: false
    end
  end
end
