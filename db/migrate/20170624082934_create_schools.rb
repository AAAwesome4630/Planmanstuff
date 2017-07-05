class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      
      t.string :name
      t.string :address
      t.string :type
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :country
      t.string :mascot
      t.string :website
      t.integer :numberOfTeachers, default: 0
      t.integer :NCES_id

      t.timestamps null: false
    end
  end
end
