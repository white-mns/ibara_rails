class AddIndexToMake < ActiveRecord::Migration[5.2]
  def change
    add_index :makes, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :makes, [:last_result_no, :e_no, :i_no, :last_generate_no], :unique => false, :name => 'last_item'
    add_index :makes,  :i_no
    add_index :makes,  :kind_id
    add_index :makes,  :strength
  end
end
