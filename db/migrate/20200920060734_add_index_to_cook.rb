class AddIndexToCook < ActiveRecord::Migration[5.2]
  def change
    add_index :cooks, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :cooks, [:result_no, :e_no, :i_no, :generate_no], :unique => false, :name => 'resultno_item'
    add_index :cooks, :cook_id
  end
end
