class CreateSkillData < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_data do |t|
      t.integer :skill_id
      t.string :name
      t.integer :type_id
      t.integer :element_id
      t.integer :ep
      t.integer :sp
      t.integer :timing_id
      t.string :text

      t.timestamps
    end
  end
end
