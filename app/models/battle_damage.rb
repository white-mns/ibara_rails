class BattleDamage < ApplicationRecord
	belongs_to :battle_info,   :foreign_key => [:result_no, :battle_id,          :generate_no], :primary_key => [:result_no, :battle_id,          :generate_no], :class_name => "BattleInfo"
	belongs_to :battle_action, :foreign_key => [:result_no, :battle_id, :act_id, :generate_no], :primary_key => [:result_no, :battle_id, :act_id, :generate_no], :class_name => "BattleAction"

    scope :includes_or_joins, ->(params) {
        includes(:battle_info)
        includes(battle_action: [:skill, :fuka, acter: [:pc_name, :world, :party, :enemy]])
    }
end
