class AddDescriptionToClassroom < ActiveRecord::Migration
  def change
    add_column :classrooms, :description, :string
  end
end
