class CreatNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :sender, index: true
      t.references :user, index: true
      t.references :conversation, index: true
      t.integer :message
      t.boolean :read, default: false
    end
    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :users, column: :sender_id
    add_foreign_key :notifications, :conversations
  end
end
