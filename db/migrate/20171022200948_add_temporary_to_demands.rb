class AddTemporaryToDemands < ActiveRecord::Migration[5.0]
  def change
    add_column :demands, :temporary, :boolean, default: false
  end
end
