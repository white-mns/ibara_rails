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
        ex_sorts = {"depth_sum desc" => 1}

        if !params[:q][:s] then
            params["ex_sort_text"] = "depth_sum desc"
            return order("depth_sum desc")

        elsif ex_sorts.has_key?(params[:q][:s]) then
            sort = params[:q][:s]
            params[:q].delete(:s)
            params["ex_sort"] = "on"
            params["ex_sort_text"] = sort
            return order(sort)

        else
            params["ex_sort_text"] = ""

        end
        nil
    }
end
