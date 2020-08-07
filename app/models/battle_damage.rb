class BattleDamage < ApplicationRecord
    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    critical   = proper_name["Critical Hit"]
    protection = proper_name["守護"]
    reflection = proper_name["反射"]

	belongs_to :battle_info,   :foreign_key => [:result_no, :battle_id,                       :generate_no], :primary_key => [:result_no, :battle_id,                       :generate_no], :class_name => "BattleInfo"
	belongs_to :battle_action, :foreign_key => [:result_no, :battle_id, :act_id,              :generate_no], :primary_key => [:result_no, :battle_id, :act_id,              :generate_no], :class_name => "BattleAction"
	belongs_to :target,        :foreign_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :primary_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :class_name => "BattleTarget"
	belongs_to :critical,    -> { where(buffer_type: critical)},   :foreign_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :primary_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :class_name => 'BattleBuffer'
	belongs_to :protection,  -> { where(buffer_type: protection)}, :foreign_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :primary_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :class_name => 'BattleBuffer'
	belongs_to :reflection,  -> { where(buffer_type: reflection)}, :foreign_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :primary_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :class_name => 'BattleBuffer'

    scope :total, ->(params) {
        select("*").
        total_damage(params).
        total_dodge(params).
        total_critical(params)
    }

    scope :total_damage, ->(params) {
        if params["show_damage"] == "1" then
            select("SUM(CASE WHEN battle_damages.value >= 0 THEN battle_damages.value ELSE 0 END) AS damage_sum")
        end
    }

    scope :total_dodge, ->(params) {
        if params["show_dodge"] == "1" then
            select("COUNT(battle_damages.damage_type = 0 or battle_damages.damage_type = 5 or null) AS dodge_count")
        else
            select("0 AS dodge_count")
        end
    }

    scope :total_critical, ->(params) {
        if params["show_critical"] == "1" then
            select("SUM(CASE WHEN battle_buffers.buffer_type = " + sprintf("%d", buffer_type) + " AND battle_buffers.value >= 0 THEN battle_buffers.value ELSE 0 END) AS critical_sum")
        end
    }

    scope :groups, ->(params) {
        group("battle_damages.result_no").
        battle_type_group(params).
        damage_type_group(params).
        group("battle_targets.e_no").
        group("battle_targets.enemy_id")
    }

    scope :pt_groups, ->(params) {
        group("battle_damages.result_no").
        damage_type_group(params).
        group("parties.party_no")
    }

    scope :damage_type_group, ->(params) {
        if params["show_dodge"] != "1" then group("damage_type") end
    }

    scope :battle_type_group, ->(params) {
        if params["group_battle_type"] == "1" then group("battle_infos.battle_type") end
    }

    scope :includes_or_joins, ->(params) {
        includes(:battle_info).
        includes(battle_action: [:skill, :fuka]).
        acter_includes(params).
        target_includes(params).
        target_pt_includes(params).
        critical_includes(params).
        protection_includes(params).
        reflection_includes(params)
    }

    scope :acter_includes, ->(params) {
        #if params["show_acter"] == "1" then includes([battle_action: [acter: [:pc_name, :world, :party, :enemy]]]) end
        includes([battle_action: [acter: [:pc_name, :world, :party, :enemy]]])
    }

    scope :target_includes, ->(params) {
        #if params["show_target"] == "1" then includes([target: [:pc_name, :world, :party, :enemy]]) end
        includes([target: [:pc_name, :world, :party, :enemy]])
    }

    scope :target_pt_includes, ->(params) {
        if params["show_target_pt"] == "1" then includes([target: [party: [party_info: [party_members: :pc_name]]]]) end
    }

    scope :critical_includes, ->(params) {
        if params["show_critical"] == "1" then includes(:critical) end
    }

    scope :protection_includes, ->(params) {
        if  params["show_prot_refl"] == "1" then includes(:protection) end
    }

    scope :reflection_includes, ->(params) {
        if params["show_prot_refl"] == "1" then includes(:reflection) end
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
