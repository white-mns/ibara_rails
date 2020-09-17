class AddBattleTypeColumnToNewBattleEnemy < ActiveRecord::Migration[5.2]
  def change
    add_column :new_battle_enemies, :battle_type, :integer
    add_index  :new_battle_enemies, :battle_type
  end
end
