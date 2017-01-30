class ChangeNotificationColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :notifications, :receiver_id, :user_id
  end
end
