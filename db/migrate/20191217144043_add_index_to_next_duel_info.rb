class AddIndexToNextDuelInfo < ActiveRecord::Migration[5.2]
  def change
    add_index :next_duel_infos, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
    add_index :next_duel_infos, :left_party_no
    add_index :next_duel_infos, :right_party_no
    add_index :next_duel_infos, :battle_type
  end
end
