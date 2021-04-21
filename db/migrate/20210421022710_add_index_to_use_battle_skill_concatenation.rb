class AddIndexToUseBattleSkillConcatenation < ActiveRecord::Migration[6.0]
  def change
    add_index :battle_use_skill_concatenations, [:result_no, :battle_id, :concatenation_type, :timing_type, :e_no, :generate_no], :unique => false, :name => 'resultno_battleid_eno'
  end
end
