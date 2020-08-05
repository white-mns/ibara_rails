class AddIndexToBattleAction < ActiveRecord::Migration[5.2]
  def change
    add_index :battle_actions, [:result_no, :battle_id, :act_id, :generate_no, :skill_id, :fuka_id], :unique => false, :name => 'resultno_battleid'
    add_index :battle_actions, [:result_no, :battle_id, :turn, :act_id, :generate_no],               :unique => false, :name => 'resultno_turn'
    add_index :battle_actions, [:result_no, :act_type,  :battle_id, :generate_no],                   :unique => false, :name => 'resultno_acttype_battleid'
    add_index :battle_actions, [:result_no, :act_type,  :turn, :generate_no],                        :unique => false, :name => 'resultno_acttype_turn'
    add_index :battle_actions, :turn
    add_index :battle_actions, :act_type
    add_index :battle_actions, :skill_id
    add_index :battle_actions, :fuka_id
  end
end
