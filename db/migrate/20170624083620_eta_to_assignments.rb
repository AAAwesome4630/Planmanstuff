class EtaToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :eta, :integer
    add_column :assignments, :rec_days, :integer
    add_column :tests, :eta, :integer
    add_column :assignments, :description, :string
    add_column :tests, :description, :string
  end
end
