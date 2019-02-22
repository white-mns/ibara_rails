class AddIndexToParty < ActiveRecord::Migration[5.2]
  def change
    add_index :parties, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :parties, :party_type
    add_index :parties, :party
  end
end
