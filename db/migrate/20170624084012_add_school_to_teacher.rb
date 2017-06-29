class AddSchoolToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :school_id, :integer, default: 0
    add_column :teachers, :classrooms, :text, default: []
  end
end
