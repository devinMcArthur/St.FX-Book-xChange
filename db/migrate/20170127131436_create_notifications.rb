class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :sender, index: true
      t.references :receiver, index: true
      t.references :conversation, index: true
      t.integer :message_id
      t.boolean :read, default: false

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users, column: :sender
    add_foreign_key :notifications, :users, column: :receiver
    add_foreign_key :notifications, :conversations
  end
end
