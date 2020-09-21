class AddIndexToAddition < ActiveRecord::Migration[5.2]
  def change
    add_index :additions, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :additions, [:result_no, :e_no, :target_i_no, :generate_no], :unique => false, :name => 'resultno_item'
    add_index :additions, :addition_id
    add_index :additions, :target_i_no
    add_index :additions, :addition_i_no
  end
end
