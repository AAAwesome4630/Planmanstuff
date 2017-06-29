class CreateTFiles < ActiveRecord::Migration
  def change
    create_table :t_files do |t|
      
      t.string :name
      t.string :file
      t.integer :classroom_id

      t.timestamps null: false
    end
  end
end
