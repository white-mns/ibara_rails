class AddIndexToBattleTarget < ActiveRecord::Migration[5.2]
  def change
    add_index :battle_targets, [:result_no, :battle_id,  :act_id, :act_sub_id, :generate_no], :unique => false, :name => 'resultno_battleid'
    add_index :battle_targets, [:result_no, :target_type, :battle_id, :generate_no], :unique => false, :name => 'resultno_targettype'
    add_index :battle_targets, :target_type
    add_index :battle_targets, :e_no
    add_index :battle_targets, :enemy_id
    add_index :battle_targets, :suffix_id
  end
end
