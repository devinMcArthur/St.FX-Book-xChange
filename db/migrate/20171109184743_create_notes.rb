class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.string :class
      t.integer :price
      t.integer :user_id

      t.timestamps
    end
  end
end
