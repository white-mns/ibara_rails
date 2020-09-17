class AddIndexToSkillConcatenates < ActiveRecord::Migration[5.2]
  def change
    add_index :skill_concatenates, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
  end
end
