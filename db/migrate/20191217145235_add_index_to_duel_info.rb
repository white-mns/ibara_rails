class AddIndexToDuelInfo < ActiveRecord::Migration[5.2]
  def change
    add_index :duel_infos, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
    add_index :duel_infos, :battle_id
    add_index :duel_infos, :left_party_no
    add_index :duel_infos, :right_party_no
  end
end
