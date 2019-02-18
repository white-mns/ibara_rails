class AddIndexToSkillData < ActiveRecord::Migration[5.2]
  def change
    add_index :skill_data, :skill_id
    add_index :skill_data, :name
    add_index :skill_data, :type_id
    add_index :skill_data, :element_id
    add_index :skill_data, :ep
    add_index :skill_data, :sp
    add_index :skill_data, :timing_id
    add_index :skill_data, :text
  end
end
