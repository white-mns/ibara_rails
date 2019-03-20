class CreateBattleDamages < ActiveRecord::Migration[5.2]
  def change
    create_table :battle_damages do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_id
      t.integer :act_id
      t.integer :act_sub_id
      t.integer :damage_type
      t.integer :element_id
      t.integer :value

      t.timestamps
    end
  end
end
