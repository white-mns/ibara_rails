class BattleBuffer < ApplicationRecord
	belongs_to :battle_info, :foreign_key => [:result_no, :battle_id, :generate_no], :primary_key => [:result_no, :battle_id, :generate_no], :class_name => "BattleInfo"
	belongs_to :buffer,  :foreign_key => :buffer_type, :primary_key => :proper_id, :class_name => "ProperName"
end
