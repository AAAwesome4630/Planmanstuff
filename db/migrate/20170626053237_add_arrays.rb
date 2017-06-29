class AddArrays < ActiveRecord::Migration
  def change
    add_column :schools, :administrators, :text, default: []
    add_column :administrators, :school_id, :integer, default:0, null: false
    add_column :schools, :teachers, :text, default: []
    add_column :schools, :students, :text, default:[]
    add_column :students, :school_id, :integer, default: 0
  end
end
