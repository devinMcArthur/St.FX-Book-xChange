class CreateDemands < ActiveRecord::Migration[5.0]
  def change
    create_table :demands do |t|
      t.text :title
      t.integer :user_id

      t.timestamps
    end
  end
end
