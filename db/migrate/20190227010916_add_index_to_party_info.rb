class AddIndexToPartyInfo < ActiveRecord::Migration[5.2]
  def change
    add_index :party_infos, [:result_no, :party_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :party_infos, :party_type
    add_index :party_infos, :name
    add_index :party_infos, :member_num
  end
end
