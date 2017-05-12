class AddNegotiatedPriceToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :negotiated_price, :string
  end
end
