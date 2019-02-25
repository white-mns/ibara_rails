class AddIndexToCompound < ActiveRecord::Migration[5.2]
  def change
    add_index :compounds, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :compounds, [:result_no, :compound_result_id, :e_no, :generate_no], :unique => false, :name => 'resultno_compoundid_eno'
    add_index :compounds, :source_1_i_no
    add_index :compounds, :source_1_name
    add_index :compounds, :source_2_i_no
    add_index :compounds, :source_2_name
    add_index :compounds, :sources_name
    add_index :compounds, :is_success
    add_index :compounds, :compound_result_id
  end
end
