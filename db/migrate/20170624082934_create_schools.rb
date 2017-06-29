class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      
      t.string :name
      t.string :address
      t.string :type
      t.string :state
      t.string :country
      t.string :mascot
      t.string :website
      t.integer :numberOfTeachers

      t.timestamps null: false
    end
  end
end
