class AddAskingPriceToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :asking_price, :string
  end
end
