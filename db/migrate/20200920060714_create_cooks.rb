class CreateCooks < ActiveRecord::Migration[5.2]
  def change
    create_table :cooks do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :requester_e_no
      t.integer :cook_id
      t.integer :last_result_no
      t.integer :last_generate_no
      t.integer :i_no
      t.string :source_name
      t.string :name

      t.timestamps
    end
  end
end
