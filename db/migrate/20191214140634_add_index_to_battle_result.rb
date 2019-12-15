class AddIndexToBattleResult < ActiveRecord::Migration[5.2]
  def change
    add_index :battle_results, [:result_no, :party_no, :generate_no], :unique => false, :name => 'resultno_partyno'
    add_index :battle_results, [:last_result_no, :party_no, :last_generate_no], :unique => false, :name => 'lastresultno_partyno'
    add_index :battle_results, :last_result_no
    add_index :battle_results, :last_generate_no
    add_index :battle_results, :battle_result
  end
end
