class AddLvToBattleAction < ActiveRecord::Migration[5.2]
  def change
    add_column :battle_actions, :lv, :integer
    add_index :battle_actions, :lv
  end
end
