class AddPasswordToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :password_digest, :string
  end
  add_index :schools, [:name, :mascot], unique: true
end
