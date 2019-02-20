class AddIndexToSkillMastery < ActiveRecord::Migration[5.2]
  def change
    add_index :skill_masteries, :skill_id
    add_index :skill_masteries, :requirement_1_id
    add_index :skill_masteries, :requirement_1_lv
    add_index :skill_masteries, :requirement_2_id
    add_index :skill_masteries, :requirement_2_lv
  end
end
