class AddFieldsToStudents < ActiveRecord::Migration
  def change
    
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
    
  end
  add_index :schools, [:name, :address], unique: true
end
