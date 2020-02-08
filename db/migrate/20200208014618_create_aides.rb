class CreateAides < ActiveRecord::Migration[5.2]
  def change
    create_table :aides do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :aide_no
      t.string :name
      t.integer :enemy_id
      t.integer :cost_sp
      t.integer :bonds
      t.integer :mhp
      t.integer :msp
      t.integer :mep
      t.integer :range
      t.string :fuka_texts
      t.string :skill_texts

      t.timestamps
    end
  end
end
