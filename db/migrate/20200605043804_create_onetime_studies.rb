class CreateOnetimeStudies < ActiveRecord::Migration[5.2]
  def change
    create_table :onetime_studies do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :skill_id
      t.integer :depth

      t.timestamps
    end
  end
end
