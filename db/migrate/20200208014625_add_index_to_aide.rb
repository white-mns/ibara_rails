class AddIndexToAide < ActiveRecord::Migration[5.2]
  def change
    add_index :aides, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :aides, :enemy_id
    add_index :aides, :cost_sp
    add_index :aides, :bonds
    add_index :aides, :mhp
    add_index :aides, :msp
    add_index :aides, :mep
    add_index :aides, :range
  end
end
