class AddFieldsToTeachers < ActiveRecord::Migration
  def change
    
    add_column :teachers, :school_id, :integer, default: 0, null: false
    add_column :teachers, :classrooms, :text, default: []
    add_column :teachers, :first_name, :string
    add_column :teachers, :last_name, :string
    add_column :teachers, :title, :string
    add_column :teachers, :avatar, :string
    
    
  end
end
