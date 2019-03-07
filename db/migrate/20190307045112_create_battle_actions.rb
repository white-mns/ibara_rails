class CreateBattleActions < ActiveRecord::Migration[5.2]
  def change
    create_table :battle_actions do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_id
      t.integer :turn
      t.integer :act_id
      t.integer :act_type
      t.integer :skill_id
      t.integer :fuka_id

      t.timestamps
    end
  end
end
