class AddIndexToNewItem < ActiveRecord::Migration[5.2]
  def change
    add_index :new_items, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
    add_index :new_items, :name
  end
end
