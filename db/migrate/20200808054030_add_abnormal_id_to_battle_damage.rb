class AddAbnormalIdToBattleDamage < ActiveRecord::Migration[5.2]
  def change
    add_column :battle_damages, :abnormal_id, :integer
    add_index :battle_damages, :abnormal_id
  end
end
