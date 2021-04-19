class AddIndexToBattleEquip < ActiveRecord::Migration[6.0]
  def change
    add_index :battle_equips, [:result_no, :battle_id, :e_no, :equip_no, :generate_no], :unique => false, :name => 'resultno_battleid_eno'
    add_index :battle_equips, :name
    add_index :battle_equips, :kind_id
    add_index :battle_equips, :strength
    add_index :battle_equips, :range
    add_index :battle_equips, :effect_1_id
    add_index :battle_equips, :effect_1_value
    add_index :battle_equips, :effect_2_id
    add_index :battle_equips, :effect_2_value
    add_index :battle_equips, :effect_3_id
    add_index :battle_equips, :effect_3_value
  end
end
