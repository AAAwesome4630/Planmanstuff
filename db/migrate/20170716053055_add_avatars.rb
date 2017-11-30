class AddAvatars < ActiveRecord::Migration
  def change
    add_column :students, :avatar, :string
    add_column :teachers, :avatar, :string
    add_column :administrators, :avatar, :string
  end
end
