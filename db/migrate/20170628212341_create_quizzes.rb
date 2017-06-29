class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      
      t.integer :classroom_id
      t.date :date
      t.string :topic
      t.string :description

      t.timestamps null: false
    end
  end
end
