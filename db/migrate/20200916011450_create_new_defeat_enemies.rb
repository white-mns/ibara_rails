class CreateNewDefeatEnemies < ActiveRecord::Migration[5.2]
  def change
    create_table :new_defeat_enemies do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :before_result_no
      t.integer :before_generate_no
      t.integer :party_no
      t.integer :enemy_id
      t.integer :member_num
      t.integer :battle_type

      t.timestamps
    end
  end
end
