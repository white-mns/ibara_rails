class Make < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

  belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :requester, :foreign_key => [:requester_e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
  belongs_to :party,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Party"
  belongs_to :last_item, :foreign_key => [:last_result_no, :requester_e_no, :i_no, :source_name, :last_generate_no], :primary_key => [:result_no, :e_no, :i_no, :name, :generate_no], :class_name => "Item"
  belongs_to :item,      :foreign_key => [:result_no, :requester_e_no, :i_no, :generate_no], :primary_key => [:result_no, :e_no, :i_no, :generate_no], :class_name => "Item"
  belongs_to :kind, :foreign_key => :kind_id, :primary_key => :proper_id, :class_name => "ProperName"
end
