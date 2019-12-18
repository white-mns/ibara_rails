class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :last_result_no
      t.integer :last_generate_no
      t.integer :i_no
      t.string :name
      t.integer :recovery
      t.integer :effect_1_id
      t.integer :effect_1_value
      t.integer :effect_2_id
      t.integer :effect_2_value
      t.integer :effect_3_id
      t.integer :effect_3_value

      t.timestamps
    end
  end
end
