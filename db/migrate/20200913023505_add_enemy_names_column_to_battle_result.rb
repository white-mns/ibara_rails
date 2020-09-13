class AddEnemyNamesColumnToBattleResult < ActiveRecord::Migration[5.2]
  def change
    add_column :battle_results, :enemy_names, :string
    add_index :battle_results, :enemy_names
  end
end
