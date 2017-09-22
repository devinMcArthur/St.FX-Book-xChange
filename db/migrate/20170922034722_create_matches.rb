class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :demand_id
      t.integer :book_id
      t.integer :weight
      t.integer :prev_match
      t.integer :streak

      t.timestamps
    end
  end
end
