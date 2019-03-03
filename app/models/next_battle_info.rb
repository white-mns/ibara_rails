class NextBattleInfo < ApplicationRecord
	belongs_to :world,      :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :e_no,     :generate_no], :class_name => "World"
	belongs_to :place,      :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :e_no,     :generate_no], :class_name => "Place"
	has_many :enemy_members, :foreign_key => [:result_no, :party_no, :battle_type, :generate_no], :primary_key => [:result_no, :party_no, :battle_type, :generate_no], :class_name => 'NextBattleEnemy'
	belongs_to :party_info,  -> { where(party_type: 1)}, :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "PartyInfo"
	belongs_to :road,      -> { where(landform_id: 1)}, :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "MovePartyCount"
	belongs_to :grass,     -> { where(landform_id: 2)}, :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "MovePartyCount"
	belongs_to :swamp,     -> { where(landform_id: 3)}, :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "MovePartyCount"
	belongs_to :forest,    -> { where(landform_id: 4)}, :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "MovePartyCount"
	belongs_to :mountain,  -> { where(landform_id: 5)}, :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "MovePartyCount"
	belongs_to :enemy_party_name, :foreign_key => :enemy_party_name_id, :primary_key => :proper_id, :class_name => "ProperName"
end
