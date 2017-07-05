class CreateIndividualTests < ActiveRecord::Migration
  def change
    create_table :individual_tests do |t|
      
      
      t.integer :test_id
      t.integer :time_remaining
      t.integer :rec_days
      t.boolean :finished, default: false
      t.integer :student_id
      t.integer :classroom_id

      t.timestamps null: false
      
    end
    add_index :individual_tests, [:test_id, :student_id], unique: true
  end
end
