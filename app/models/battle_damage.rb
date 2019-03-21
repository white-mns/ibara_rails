class BattleDamage < ApplicationRecord
    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    critical = proper_name["Critical Hit"]

	belongs_to :battle_info,   :foreign_key => [:result_no, :battle_id,                       :generate_no], :primary_key => [:result_no, :battle_id,                       :generate_no], :class_name => "BattleInfo"
	belongs_to :battle_action, :foreign_key => [:result_no, :battle_id, :act_id,              :generate_no], :primary_key => [:result_no, :battle_id, :act_id,              :generate_no], :class_name => "BattleAction"
	belongs_to :target,        :foreign_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :primary_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :class_name => "BattleTarget"
	belongs_to :critical,  -> { where(buffer_type: critical)},     :foreign_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :primary_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :class_name => 'BattleBuffer'

    scope :total, ->(params) {
        select("*").
        select("COUNT(battle_damages.damage_type = 0 or null) AS dodge_count").
        select("SUM(CASE WHEN battle_damages.value >= 0 THEN battle_damages.value ELSE 0 END) AS damage_sum")
    }

    scope :groups, ->(params) {
        group("battle_damages.result_no").
        group("battle_infos.battle_type").
        group("battle_damages.damage_type").
        group("battle_targets.e_no").
        group("battle_targets.enemy_id")
    }

    scope :pt_groups, ->(params) {
        group("battle_damages.result_no").
        group("battle_damages.damage_type").
        group("parties.party_no")
    }

    scope :includes_or_joins, ->(params) {
        includes(:battle_info).
        includes(battle_action: [:skill, :fuka]).
        acter_includes(params).
        target_includes(params).
        critical_includes(params)
    }

    scope :acter_includes, ->(params) {
        #if params["show_acter"] == "1" then includes([battle_action: [acter: [:pc_name, :world, :party, :enemy]]]) end
        includes([battle_action: [acter: [:pc_name, :world, :party, :enemy]]])
    }

    scope :target_includes, ->(params) {
        #if params["show_target"] == "1" then includes([target: [:pc_name, :world, :party, :enemy]]) end
        includes([target: [:pc_name, :world, :party, :enemy]])
    }

    scope :critical_includes, ->(params) {
        if params["show_critical"] == "1" then includes(:critical) end
    }

    scope :having_order, ->(params) {
        ex_sorts = {"dodge_count desc" => 1, "damage_sum desc" => 1}
        if !params[:q][:s] then
            params["ex_sort_text"] = "act_count desc"
            return order("act_count desc")

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
