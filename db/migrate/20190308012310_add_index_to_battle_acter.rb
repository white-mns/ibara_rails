class AddIndexToBattleActer < ActiveRecord::Migration[5.2]
  def change
    add_index :battle_acters, [:result_no, :battle_id, :act_id, :generate_no], :unique => false, :name => 'resultno_battleid'
    add_index :battle_acters, [:result_no, :acter_type,  :battle_id, :generate_no], :unique => false, :name => 'resultno_acttype'
    add_index :battle_acters,  :acter_type
    add_index :battle_acters,  :e_no
    add_index :battle_acters,  :enemy_id
    add_index :battle_acters,  :suffix_id
  end
end
