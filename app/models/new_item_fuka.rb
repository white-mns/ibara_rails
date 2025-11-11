class NewItemFuka < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :fuka, :foreign_key => :fuka_id, :primary_key => :proper_id, :class_name => "ProperName"
end
