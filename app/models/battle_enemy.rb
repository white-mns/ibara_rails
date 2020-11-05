class BattleEnemy < ApplicationRecord
  belongs_to :world,      :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :e_no,     :generate_no], :class_name => "World"
  belongs_to :enemy, :foreign_key => :enemy_id, :primary_key => :proper_id, :class_name => "ProperName"
end
