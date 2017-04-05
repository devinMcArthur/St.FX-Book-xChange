class ChangeNotificationColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :notifications, :message, :message_id
  end
end
