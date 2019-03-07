class BattleAction < ApplicationRecord
	belongs_to :battle_info, :foreign_key => [:result_no, :battle_id, :generate_no], :primary_key => [:result_no, :battle_id, :generate_no], :class_name => "BattleInfo"
	belongs_to :skill, :foreign_key => :skill_id, :primary_key => :skill_id,  :class_name => "SkillDatum"
	belongs_to :fuka,  :foreign_key => :fuka_id,  :primary_key => :proper_id, :class_name => "ProperName"

    scope :total, ->(params) {
        select("*").
        select("COUNT(battle_actions.id) AS use_count").
        select("COUNT(DISTINCT battle_actions.battle_id) AS page_count")
    }

    scope :includes_or_joins_and_total, ->(params) {
        #if params["show_party_count"] == "on" then
        #    joins(:battle_info).
        #    select("COUNT(battle_actions.battle_id) AS party_count")
        #else
        #    includes(:battle_info).
        #    select("\"-\" AS party_count")
        #end
    }
    scope :groups, ->(params) {
        group("battle_actions.result_no").
        group_page(params).
        group_turn(params).
        group("battle_actions.skill_id, battle_actions.fuka_id")
    }
  
    scope :group_page, ->(params) {
        if params["group_page"] == "on" then
            group("battle_actions.battle_id")
        end
    }

    scope :group_turn, ->(params) {
        if params["group_turn"] == "on" then
            group("battle_actions.turn")
        end
    }

    scope :having_order, ->(params) {
        if params["group_page"] == "on" then
            return
        end

        if !params[:q][:s] then
            return order("use_count desc")

        elsif params[:q][:s].include?(" ") then
            sort = params[:q][:s]
            params[:q].delete(:s)
            return order(sort)
        end
        nil
    }

end
