class CreateIndividualQuizzes < ActiveRecord::Migration
  def change
    create_table :individual_quizzes do |t|
      
      t.integer :quiz_id
      t.integer :student_id
      t.integer :time_remaining
      t.integer :rec_days
      t.boolean :finshed, default: false

      t.timestamps null: false
    end
  end
end
