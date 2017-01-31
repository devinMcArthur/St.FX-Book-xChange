class HerokuNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :sender_id, index: true
      t.references :user_id, index: true
      t.references :conversation_id, index: true
      t.integer :message_id
      t.boolean :read, default: false

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :users, column: :user_id_id
    add_foreign_key :notifications, :conversations, column: :conversation_id
  end
end
