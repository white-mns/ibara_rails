class Skill < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
	belongs_to :place,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Place"
	belongs_to :party,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Party"
	belongs_to :status,  :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Status"

	belongs_to :skill,         :foreign_key => :skill_id, :primary_key => :skill_id, :class_name => "SkillDatum"
	belongs_to :skill_mastery, :foreign_key => :skill_id, :primary_key => :skill_id, :class_name => "SkillMastery"

    scope :groups, ->(params) {
        if params["show_total"] == "1" then
            group("skills.result_no").
            group("skills.skill_id")
        end
    }
 
    scope :aggregations, ->(params) {
        if params["show_total"] == "1" then
            select("*").
            select("COUNT(skills.id) AS user_count")
        end
    }

    scope :having_order, ->(params) {
        ex_sorts = {"user_count desc" => 1}
        if !params[:q][:s] then
            params["ex_sort_text"] = "user_count desc"
            return order("user_count desc")

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
