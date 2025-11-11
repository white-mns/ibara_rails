class Party < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :pc_name,    :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :world,      :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
	belongs_to :party_info, :foreign_key => [:result_no, :party_no, :party_type, :generate_no], :primary_key => [:result_no, :party_no, :party_type, :generate_no], :class_name => "PartyInfo"
	has_many :move,    :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Move"

    scope :pc_to_party_member_array, ->(params)   {
        parties = Party.notnil().includes(:pc_name).ransack(params[:q]).result.pluck(:party_no)
        e_nos = []
        parties.each do |party|
            e_nos.push(Party.notnil().includes(:pc_name).where(party_no: parties).pluck(:e_no))
        end
        e_nos.flatten.uniq
    }
end
