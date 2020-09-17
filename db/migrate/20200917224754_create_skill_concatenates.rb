class CreateSkillConcatenates < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_concatenates do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.text :skill_concatenate

      t.timestamps
    end
  end
end
