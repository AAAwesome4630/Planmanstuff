class CreateIndividualAssignments < ActiveRecord::Migration
  def change
    create_table :individual_assignments do |t|

      
      t.integer :assignment_id
      t.integer :time_remaining
      t.boolean :finished, default: false
      t.integer :student_id
      t.integer :rec_days
      t.integer :classroom_id
      
      t.timestamps null: false
      
      
    end
    add_index :individual_assignments, [:assignment_id, :student_id], unique: true
  end
end
