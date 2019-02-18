class CreateSuperpowers < ActiveRecord::Migration[5.2]
  def change
    create_table :superpowers do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :superpower_id
      t.integer :lv

      t.timestamps
    end
  end
end
