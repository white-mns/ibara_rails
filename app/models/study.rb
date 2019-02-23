class Study < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
	belongs_to :party,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Party"
	belongs_to :skill,         :foreign_key => :skill_id, :primary_key => :skill_id, :class_name => "SkillDatum"

    scope :for_group_select, ->(action_name, params) {
        if params["group_skill"] == "on"then
            select("*").
            select("SUM(depth) AS depth_sum")
        end
    }

    scope :groups, ->(action_name, params) {
        group("studies.result_no, studies.generate_no").
        group_e_no(params).
        group_card(params)
    }
    
    scope :group_e_no, ->(params) {
        if params["group_skill"] != "on"then
            group("studies.e_no")
        end
    }

    scope :group_card, ->(params) {
        group(:skill_id)
    }

    scope :having_order, ->(params) {
        if params["group_skill"] != "on"then
            return
        end

        if !params[:q][:s] then
            return order("depth_sum desc")

        elsif params[:q][:s].include?(" ") then
            sort = params[:q][:s]
            if sort.split(" ")[0] == "depth_sum" then
                params[:q].delete(:s)
                return order(sort)
            end
        end
        nil
    }
end
