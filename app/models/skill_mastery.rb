class SkillMastery < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :skill, :foreign_key => :skill_id, :primary_key => :skill_id, :class_name => "SkillDatum"
	belongs_to :requirement_1, :foreign_key => :requirement_1_id, :primary_key => :proper_id, :class_name => "ProperName"
	belongs_to :requirement_2, :foreign_key => :requirement_2_id, :primary_key => :proper_id, :class_name => "ProperName"
end
