class AddAvatarsto < ActiveRecord::Migration
  def change
    add_column :teachers, :avatar, :string
    add_column :administrators, :avatar, :string
  end
end
