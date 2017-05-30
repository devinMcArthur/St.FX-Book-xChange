class AddVisibilityToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :visible, :boolean, default: true
  end
end
