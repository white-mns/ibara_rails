class CreateAdditions < ActiveRecord::Migration[5.2]
  def change
    create_table :additions do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :requester_e_no
      t.integer :addition_id
      t.integer :last_result_no
      t.integer :last_generate_no
      t.integer :target_i_no
      t.string :target_name
      t.integer :addition_i_no
      t.string :addition_name

      t.timestamps
    end
  end
end
