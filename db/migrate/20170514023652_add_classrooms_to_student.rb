class AddClassroomsToStudent < ActiveRecord::Migration
  def change
    add_column :students, :classrooms, :text, default: []
  end
end
