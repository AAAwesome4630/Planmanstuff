class CreateScRelationships < ActiveRecord::Migration
  def change
    create_table :sc_relationships do |t|
      
      t.integer :classroom_id
      t.integer :student_id

      t.timestamps null: false
    end
    add_index :sc_relationships, :classroom_id
    add_index :sc_relationships, :student_id
    add_index :sc_relationships, [:classroom_id, :student_id], unique: true
  end
end
