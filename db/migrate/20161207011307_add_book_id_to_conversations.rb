class AddBookIdToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :book_id, :integer
  end
end
