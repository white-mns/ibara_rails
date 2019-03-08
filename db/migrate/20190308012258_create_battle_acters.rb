class CreateBattleActers < ActiveRecord::Migration[5.2]
  def change
    create_table :battle_acters do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_id
      t.integer :act_id
      t.integer :acter_type
      t.integer :e_no
      t.integer :enemy_id
      t.integer :suffix_id

      t.timestamps
    end
  end
end
