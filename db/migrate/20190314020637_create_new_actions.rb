class CreateNewActions < ActiveRecord::Migration[5.2]
  def change
    create_table :new_actions do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :skill_id
      t.integer :fuka_id

      t.timestamps
    end
  end
end
