class CreateIndividualTests < ActiveRecord::Migration
  def change
    create_table :individual_tests do |t|
      
      
      t.integer :test_id
      t.integer :time_remaining
      t.integer :rec_days
      t.boolean :finished, default: false
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
