class AddFieldsToAdministrators < ActiveRecord::Migration
  def change
    
    add_column :administrators, :first_name, :string
    add_column :administrators, :last_name, :string
    add_column :administrators, :title, :string
    add_column :administrators, :admin, :boolean, default: false
    add_column :administrators, :avatar, :string
    
  end
end
