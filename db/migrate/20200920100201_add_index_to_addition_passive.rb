class AddIndexToAdditionPassive < ActiveRecord::Migration[5.2]
  def change
    add_index :addition_passives, [:result_no, :requester_e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :addition_passives, :skill_id
    add_index :addition_passives, :result
    add_index :addition_passives, :increase
    add_index :addition_passives, :dice_total
  end
end
