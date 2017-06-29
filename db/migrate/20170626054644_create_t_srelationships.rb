class CreateTSrelationships < ActiveRecord::Migration
  def change
    create_table :t_srelationships do |t|
      
      t.integer :teacher_id
      t.integer :school_id

      t.timestamps null: false
    end
    add_index :t_srelationships, [:school_id, :teacher_id], unique: true
  end
end
