class CreateBattleResults < ActiveRecord::Migration[5.2]
  def change
    create_table :battle_results do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :party_no
      t.integer :battle_type
      t.integer :last_result_no
      t.integer :last_generate_no
      t.integer :battle_id
      t.integer :battle_result

      t.timestamps
    end
  end
end
