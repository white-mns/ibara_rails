class CreateSkillMasteries < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_masteries do |t|
      t.integer :skill_id
      t.integer :requirement_1_id
      t.integer :requirement_1_lv
      t.integer :requirement_2_id
      t.integer :requirement_2_lv

      t.timestamps
    end
  end
end
