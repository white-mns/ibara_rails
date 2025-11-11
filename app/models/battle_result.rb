class BattleResult < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :battle_info, :foreign_key => [:result_no, :battle_id, :generate_no], :primary_key => [:result_no, :battle_id, :generate_no], :class_name => "BattleInfo"
	belongs_to :last_battle_info, :foreign_key => [:last_result_no, :party_no, :last_generate_no, :battle_type], :primary_key => [:result_no, :party_no, :generate_no, :battle_type], :class_name => "NextBattleInfo"
	has_many :enemy_members, :foreign_key => [:result_no, :party_no, :battle_type, :generate_no], :primary_key => [:result_no, :party_no, :battle_type, :generate_no], :class_name => 'BattleEnemy'
	belongs_to :party_info,  -> { where(party_type: 0)}, :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "PartyInfo"
end
