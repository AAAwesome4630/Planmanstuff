class CreateSSrelationships < ActiveRecord::Migration
  def change
    create_table :s_srelationships do |t|
      
      t.integer :student_id
      t.integer :school_id

      t.timestamps null: false
    end
    add_index :s_srelationships, [:school_id, :student_id], unique: true
  end
end
