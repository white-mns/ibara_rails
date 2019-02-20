class Item < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
	belongs_to :place,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Place"
	belongs_to :kind, :foreign_key => :kind_id, :primary_key => :proper_id, :class_name => "ProperName"
	belongs_to :effect_1, :foreign_key => :effect_1_id, :primary_key => :proper_id, :class_name => "ProperName"
	belongs_to :effect_2, :foreign_key => :effect_2_id, :primary_key => :proper_id, :class_name => "ProperName"
	belongs_to :effect_3, :foreign_key => :effect_3_id, :primary_key => :proper_id, :class_name => "ProperName"
end
