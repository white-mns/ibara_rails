class AddIndexToBattleInfo < ActiveRecord::Migration[5.2]
  def change
    add_index :battle_infos, [:result_no, :battle_id, :generate_no], :unique => false, :name => 'resultno_battleid'
    add_index :battle_infos, :battle_type
  end
end
