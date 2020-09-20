class CreateAdditionPassives < ActiveRecord::Migration[5.2]
  def change
    create_table :addition_passives do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :requester_e_no
      t.integer :addition_id
      t.integer :skill_id
      t.integer :result
      t.integer :increase
      t.integer :dice_total
      t.integer :dice_1
      t.integer :dice_2
      t.integer :dice_3
      t.integer :dice_4
      t.integer :dice_5
      t.integer :dice_6

      t.timestamps
    end
  end
end
