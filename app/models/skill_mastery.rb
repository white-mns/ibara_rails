class SkillMastery < ApplicationRecord
  belongs_to :skill, :foreign_key => :skill_id, :primary_key => :skill_id, :class_name => "SkillDatum"
  belongs_to :requirement_1, :foreign_key => :requirement_1_id, :primary_key => :proper_id, :class_name => "ProperName"
  belongs_to :requirement_2, :foreign_key => :requirement_2_id, :primary_key => :proper_id, :class_name => "ProperName"
end
