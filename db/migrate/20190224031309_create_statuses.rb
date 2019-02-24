class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :style_id
      t.integer :effect
      t.integer :mhp
      t.integer :msp
      t.integer :landform_id
      t.integer :condition
      t.integer :max_condition
      t.integer :ps

      t.timestamps
    end
  end
end
