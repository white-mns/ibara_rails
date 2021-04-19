class CreateBattleEquips < ActiveRecord::Migration[6.0]
  def change
    create_table :battle_equips do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :battle_id
      t.integer :equip_no
      t.string :name
      t.integer :kind_id
      t.integer :strength
      t.integer :range
      t.integer :effect_1_id
      t.integer :effect_1_value
      t.integer :effect_2_id
      t.integer :effect_2_value
      t.integer :effect_3_id
      t.integer :effect_3_value

      t.timestamps
    end
  end
end
