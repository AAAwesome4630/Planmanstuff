class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      
      t.date :date
      t.string :topic
      t.integer :classroom_id
      t.integer :rec_days
      t.integer :eta
      t.string :description
      


      t.timestamps null: false
    end
  end
end
