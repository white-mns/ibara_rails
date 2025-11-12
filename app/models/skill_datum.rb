class SkillDatum < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

  belongs_to :timing,        :foreign_key => :timing_id, :primary_key => :proper_id, :class_name => "ProperName"
  belongs_to :skill_mastery, :foreign_key => :skill_id,  :primary_key => :skill_id,  :class_name => "SkillMastery"
end
