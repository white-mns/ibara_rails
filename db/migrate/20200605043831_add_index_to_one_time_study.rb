class AddIndexToOneTimeStudy < ActiveRecord::Migration[5.2]
  def change
    add_index :onetime_studies, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :onetime_studies, :skill_id
    add_index :onetime_studies, :depth
  end
end
