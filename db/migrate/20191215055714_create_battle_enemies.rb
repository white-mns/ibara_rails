class CreateBattleEnemies < ActiveRecord::Migration[5.2]
  def change
    create_table :battle_enemies do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :party_no
      t.integer :battle_type
      t.integer :enemy_id

      t.timestamps
    end
  end
end
