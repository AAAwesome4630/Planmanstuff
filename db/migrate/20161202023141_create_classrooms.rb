class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      
      t.string :name, null: false
      t.string :subject
      t.integer :numberOfStudents, default: 0, null: false
      t.integer :teacher_id
      t.string :description
      t.string :password_digest
      

      t.timestamps null: false
    end
    add_index :classrooms, [:name, :teacher_id]
  end
end
