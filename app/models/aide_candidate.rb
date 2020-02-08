class AideCandidate < ApplicationRecord
    superpower_name = SuperpowerDatum.pluck(:name, :superpower_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    employ = superpower_name["使役"]

	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
	belongs_to :party,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Party"
	belongs_to :employ,  -> { where(superpower_id: employ)},   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Superpower"
	belongs_to :last_employ,  -> { where(superpower_id: employ)},   :foreign_key => [:e_no, :last_result_no, :last_generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Superpower"
	belongs_to :enemy, :foreign_key => :enemy_id, :primary_key => :proper_id, :class_name => "ProperName"
end
