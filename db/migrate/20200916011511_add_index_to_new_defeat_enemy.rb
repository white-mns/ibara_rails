class AddIndexToNewDefeatEnemy < ActiveRecord::Migration[5.2]
  def change
    add_index :new_defeat_enemies, [:result_no, :party_no, :generate_no], :unique => false, :name => 'resultno_partyno'
    add_index :new_defeat_enemies, [:before_result_no, :party_no, :before_generate_no], :unique => false, :name => 'beforeresultno_partyno'
    add_index :new_defeat_enemies, :enemy_id
    add_index :new_defeat_enemies, :member_num
    add_index :new_defeat_enemies, :battle_type
  end
end
