class AddSortIndexToBattleDamage < ActiveRecord::Migration[5.2]
  def change
    add_index :battle_damages, [:result_no, :damage_type, :value], :unique => false, :name => 'sort_value'
    add_index :battle_damages, [:result_no, :damage_type, :abnormal_id, :value], :unique => false, :name => 'sort_abnormalid_value'
  end
end
