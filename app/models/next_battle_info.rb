class NextBattleInfo < ApplicationRecord
	belongs_to :world,      :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :e_no,     :generate_no], :class_name => "World"
	belongs_to :place,      :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :e_no,     :generate_no], :class_name => "Place"
	belongs_to :party_info,  -> { where(party_type: 1)}, :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "PartyInfo"
	belongs_to :enemy_party_name, :foreign_key => :enemy_party_name_id, :primary_key => :proper_id, :class_name => "ProperName"
end
