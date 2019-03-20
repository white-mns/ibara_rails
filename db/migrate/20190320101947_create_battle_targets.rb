class CreateBattleTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :battle_targets do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_id
      t.integer :act_id
      t.integer :act_sub_id
      t.integer :target_type
      t.integer :e_no
      t.integer :enemy_id
      t.integer :suffix_id

      t.timestamps
    end
  end
end
