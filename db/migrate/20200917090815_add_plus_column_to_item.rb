class AddPlusColumnToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :plus, :integer
    add_index  :items, :plus
  end
end
