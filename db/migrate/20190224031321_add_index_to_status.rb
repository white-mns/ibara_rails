class AddIndexToStatus < ActiveRecord::Migration[5.2]
  def change
    add_index :statuses, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :statuses, :style_id
    add_index :statuses, :effect
    add_index :statuses, :mhp
    add_index :statuses, :msp
    add_index :statuses, :landform_id
    add_index :statuses, :condition
    add_index :statuses, :max_condition
    add_index :statuses, :ps
  end
end
