class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string  :event_type
      t.string  :event_id
      t.boolean :read, default: false

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
