class NewAction < ApplicationRecord
  belongs_to :skill, :foreign_key => :skill_id, :primary_key => :skill_id,  :class_name => "SkillDatum"
  belongs_to :fuka,  :foreign_key => :fuka_id,  :primary_key => :proper_id, :class_name => "ProperName"
end
