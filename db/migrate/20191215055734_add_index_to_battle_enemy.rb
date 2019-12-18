class AddIndexToBattleEnemy < ActiveRecord::Migration[5.2]
  def change
    add_index :battle_enemies, [:result_no, :party_no, :generate_no], :unique => false, :name => 'resultno_partyno'
    add_index :battle_enemies, :battle_type
    add_index :battle_enemies, :enemy_id
  end
end
