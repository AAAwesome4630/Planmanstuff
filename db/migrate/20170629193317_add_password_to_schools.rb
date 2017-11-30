class AddPasswordToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :password_digest, :string
  end
end
