class AddIndexToWorld < ActiveRecord::Migration[5.2]
  def change
    add_index :worlds, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :worlds, :world
  end
end
