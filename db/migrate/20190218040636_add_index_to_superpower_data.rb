class AddIndexToSuperpowerData < ActiveRecord::Migration[5.2]
  def change
    add_index :superpower_data, :superpower_id
    add_index :superpower_data, :name
  end
end
