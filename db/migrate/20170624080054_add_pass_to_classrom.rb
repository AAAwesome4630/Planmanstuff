class AddPassToClassrom < ActiveRecord::Migration
  def change
    add_column :classrooms, :password_digest, :string
  end
end
