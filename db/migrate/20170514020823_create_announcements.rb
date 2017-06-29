class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      
      t.string :header
      t.string :content
      t.integer :classroom_id


      t.timestamps null: false
    end
  end
end
