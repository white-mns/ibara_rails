class AddEnemyNamesColumnToNextBattleInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :next_battle_infos, :enemy_names, :string
    add_index :next_battle_infos, :enemy_names
  end
end
