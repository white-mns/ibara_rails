class SkillDatum < ApplicationRecord
	belongs_to :timing,        :foreign_key => :timing_id, :primary_key => :proper_id, :class_name => "ProperName"
	belongs_to :skill_mastery, :foreign_key => :skill_id,  :primary_key => :skill_id,  :class_name => "SkillMastery"
end
