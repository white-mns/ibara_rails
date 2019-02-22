class Party < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"

    scope :pc_to_party_member_array, ->(params)   {
        parties = Party.notnil().includes(:pc_name).search(params[:q]).result.pluck(:party)
        parties
    }
end