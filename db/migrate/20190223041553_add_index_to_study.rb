class AddIndexToStudy < ActiveRecord::Migration[5.2]
  def change
    add_index :studies, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :studies, :skill_id
    add_index :studies, :depth
  end
end
