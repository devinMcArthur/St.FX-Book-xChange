class HerokuNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :sender_id, index: true
      t.integer :user_id, index: true
      t.integer :conversation_id, index: true
      t.integer :message_id
      t.boolean :read, default: false

      t.timestamps null: false
    end
  end
end
