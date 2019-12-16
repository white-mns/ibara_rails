class AddIndexToNewBattleEnemy < ActiveRecord::Migration[5.2]
  def change
    add_index :new_battle_enemies, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
    add_index :new_battle_enemies, :enemy_id
  end
end
