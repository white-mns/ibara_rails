class CreateCompounds < ActiveRecord::Migration[5.2]
  def change
    create_table :compounds do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :last_result_no
      t.integer :last_generate_no
      t.integer :source_1_i_no
      t.string :source_1_name
      t.integer :source_2_i_no
      t.string :source_2_name
      t.string :sources_name
      t.integer :is_success
      t.integer :compound_result_id

      t.timestamps
    end
  end
end
