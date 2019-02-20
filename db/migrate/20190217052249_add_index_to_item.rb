class AddIndexToItem < ActiveRecord::Migration[5.2]
  def change
    add_index :items, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :items, :name
    add_index :items, :kind_id
    add_index :items, :strength
    add_index :items, :range
    add_index :items, :effect_1_id
    add_index :items, :effect_1_value
    add_index :items, :effect_1_need_lv
    add_index :items, :effect_2_id
    add_index :items, :effect_2_value
    add_index :items, :effect_2_need_lv
    add_index :items, :effect_3_id
    add_index :items, :effect_3_value
    add_index :items, :effect_3_need_lv
  end
end
