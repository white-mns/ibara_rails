class AddIndexToCard < ActiveRecord::Migration[5.2]
  def change
    add_index :cards, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :cards, :name
    add_index :cards, :skill_id
    add_index :cards, :made_e_no
  end
end
