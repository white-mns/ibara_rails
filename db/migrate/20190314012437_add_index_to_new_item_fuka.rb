class AddIndexToNewItemFuka < ActiveRecord::Migration[5.2]
  def change
    add_index :new_item_fukas, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
    add_index :new_item_fukas, :fuka_id
  end
end
