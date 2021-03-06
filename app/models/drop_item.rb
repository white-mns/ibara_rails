class DropItem < ApplicationRecord
  belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
  belongs_to :place,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Place"
  belongs_to :party,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Party"
  belongs_to :item,    :foreign_key => [:e_no, :result_no, :generate_no, :name], :primary_key => [:e_no, :result_no, :generate_no, :name], :class_name => "Item"
end
