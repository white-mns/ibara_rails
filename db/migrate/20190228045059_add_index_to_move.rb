class AddIndexToMove < ActiveRecord::Migration[5.2]
  def change
    add_index :moves, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :moves, :move_no
    add_index :moves, :field_id
    add_index :moves, :area
    add_index :moves, :area_column
    add_index :moves, :area_row
    add_index :moves, :landform_id


  end
end
