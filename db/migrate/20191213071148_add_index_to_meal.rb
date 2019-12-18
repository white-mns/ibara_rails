class AddIndexToMeal < ActiveRecord::Migration[5.2]
  def change
    add_index :meals, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :meals, [:last_result_no, :e_no, :i_no, :last_generate_no], :unique => false, :name => 'last_item'
    add_index :meals, :name
    add_index :meals, :recovery
    add_index :meals, :effect_1_id
    add_index :meals, :effect_1_value
    add_index :meals, :effect_2_id
    add_index :meals, :effect_2_value
    add_index :meals, :effect_3_id
    add_index :meals, :effect_3_value
  end
end
