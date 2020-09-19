class AddIndexToDropItem < ActiveRecord::Migration[5.2]
  def change
    add_index :drop_items, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :drop_items, :name
    add_index :drop_items, :plus
  end
end
