class AddIndexToPlace < ActiveRecord::Migration[5.2]
  def change
    add_index :places, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :places, [:result_no, :field_id, :area_column, :area_row, :generate_no], :unique => false, :name => 'resultno_place_col_row'
    add_index :places, [:result_no, :field_id, :area, :generate_no], :unique => false, :name => 'resultno_place_area'
    add_index :places, :field_id
    add_index :places, :area
    add_index :places, :area_column
    add_index :places, :area_row
  end
end
