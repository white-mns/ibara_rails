class AddIndexToAideCandidate < ActiveRecord::Migration[5.2]
  def change
    add_index :aide_candidates, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :aide_candidates, [:last_result_no, :e_no, :last_generate_no], :unique => false, :name => 'lastresultno_eno'
    add_index :aide_candidates,  :enemy_id
  end
end
