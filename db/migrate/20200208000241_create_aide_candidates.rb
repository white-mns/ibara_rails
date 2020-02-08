class CreateAideCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :aide_candidates do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :last_result_no
      t.integer :last_generate_no
      t.integer :enemy_id

      t.timestamps
    end
  end
end
