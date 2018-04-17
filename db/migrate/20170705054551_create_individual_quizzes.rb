class CreateIndividualQuizzes < ActiveRecord::Migration
  def change
    create_table :individual_quizzes do |t|
      
      t.integer :quiz_id
      t.integer :time_remaining
      t.integer :rec_days
      t.boolean :finished, default: false
      t.integer :student_id
      t.integer :classroom_id
      t.date :date


      t.timestamps null: false
    end
    add_index :individual_quizzes, [:quiz_id, :student_id], unique: true
  end
end
