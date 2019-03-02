class AddIndexToMovePartyCount < ActiveRecord::Migration[5.2]
  def change
    add_index :move_party_counts, [:result_no, :party_no, :generate_no], :unique => false, :name => 'resultno_partyno'
    add_index :move_party_counts, :landform_id
    add_index :move_party_counts, :move_count
  end
end
