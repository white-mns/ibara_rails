class CookPassive < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:requester_e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :world,   :foreign_key => [:requester_e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
	belongs_to :skill, :foreign_key => :skill_id, :primary_key => :skill_id, :class_name => "SkillDatum"
end
