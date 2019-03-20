class AddIndexToBattleDamage < ActiveRecord::Migration[5.2]
  def change
    add_index :battle_damages, [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :unique => false, :name => 'resultno_battleid'
    add_index :battle_damages, [:result_no, :damage_type, :battle_id, :act_id, :act_sub_id, :generate_no], :unique => false, :name => 'resultno_damagetype'
    add_index :battle_damages, :element_id
    add_index :battle_damages, :value
  end
end
