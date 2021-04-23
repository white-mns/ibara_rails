class CreateBattleUseSkillConcatenations < ActiveRecord::Migration[6.0]
  def change
    create_table :battle_use_skill_concatenations do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_id
      t.integer :concatenation_type
      t.integer :timing_type
      t.integer :e_no
      t.text :skill_concatenation

      t.timestamps
    end
  end
end
