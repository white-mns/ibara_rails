class Party < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
	has_many :move,    :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Move"

    scope :pc_to_party_member_array, ->(params)   {
        parties = Party.notnil().includes(:pc_name).search(params[:q]).result.pluck(:party_no)
        e_nos = []
        parties.each do |party|
            e_nos.push(Party.notnil().includes(:pc_name).where(party_no: parties).pluck(:e_no))
        end
        e_nos.flatten.uniq
    }
end
