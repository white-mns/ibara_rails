class CreateMakes < ActiveRecord::Migration[5.2]
  def change
    create_table :makes do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :last_result_no
      t.integer :last_generate_no
      t.integer :i_no
      t.string :name
      t.integer :kind_id
      t.integer :strength

      t.timestamps
    end
  end
end
