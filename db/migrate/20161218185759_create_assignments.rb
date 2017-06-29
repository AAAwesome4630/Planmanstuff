class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.date :due_date
      t.string :name
      t.integer :classroom_id

      t.timestamps null: false
    end
  end
end
