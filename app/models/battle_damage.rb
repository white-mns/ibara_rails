class BattleDamage < ApplicationRecord
    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    critical = proper_name["Critical Hit"]

	belongs_to :battle_info,   :foreign_key => [:result_no, :battle_id,                       :generate_no], :primary_key => [:result_no, :battle_id,                       :generate_no], :class_name => "BattleInfo"
	belongs_to :battle_action, :foreign_key => [:result_no, :battle_id, :act_id,              :generate_no], :primary_key => [:result_no, :battle_id, :act_id,              :generate_no], :class_name => "BattleAction"
	belongs_to :target,        :foreign_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :primary_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :class_name => "BattleTarget"
	belongs_to :critical,  -> { where(buffer_type: critical)},     :foreign_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :primary_key => [:result_no, :battle_id, :act_id, :act_sub_id, :generate_no], :class_name => 'BattleBuffer'

    scope :includes_or_joins, ->(params) {
        includes(:battle_info).
        includes(battle_action: [:skill, :fuka]).
        acter_includes(params).
        target_includes(params).
        includes(:critical)
    }

    scope :acter_includes, ->(params) {
        #if params["show_acter"] == "1" then includes([battle_action: [acter: [:pc_name, :world, :party, :enemy]]]) end
        includes([battle_action: [acter: [:pc_name, :world, :party, :enemy]]])
    }

    scope :target_includes, ->(params) {
        #if params["show_target"] == "1" then includes([target: [:pc_name, :world, :party, :enemy]]) end
        includes([target: [:pc_name, :world, :party, :enemy]])
    }
end
