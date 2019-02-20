class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.string :name
      t.integer :skill_id
      t.integer :lv

      t.timestamps
    end
  end
end
