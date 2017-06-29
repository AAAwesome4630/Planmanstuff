class CreateAdminAnnouncements < ActiveRecord::Migration
  def change
    create_table :admin_announcements do |t|
      
      t.integer :admin_id
      t.string :header
      t.string :content

      t.timestamps null: false
    end
  end
end
