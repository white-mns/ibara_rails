class AddIndexToSuperpower < ActiveRecord::Migration[5.2]
  def change
    add_index :superpowers, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :superpowers, :superpower_id
    add_index :superpowers, :lv
  end
end
