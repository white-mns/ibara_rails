class AddIndexToCookPassive < ActiveRecord::Migration[5.2]
  def change
    add_index :cook_passives, [:result_no, :requester_e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :cook_passives, :skill_id
    add_index :cook_passives, :result
    add_index :cook_passives, :increase
    add_index :cook_passives, :dice_total
  end
end
