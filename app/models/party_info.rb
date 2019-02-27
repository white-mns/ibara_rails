class PartyInfo < ApplicationRecord
	belongs_to :world,       :foreign_key => [:result_no, :party_no,              :generate_no], :primary_key => [:result_no, :e_no,                  :generate_no], :class_name => "World"
	has_many :party_members, :foreign_key => [:result_no, :party_no, :party_type, :generate_no], :primary_key => [:result_no, :party_no, :party_type, :generate_no], :class_name => 'Party'
	belongs_to :place,       :foreign_key => [:result_no, :party_no,              :generate_no], :primary_key => [:result_no, :e_no,                  :generate_no], :class_name => "Place"
end
