class BattleUseSkillConcatenation < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

  belongs_to :battle_info, :foreign_key => [:result_no, :battle_id, :generate_no], :primary_key => [:result_no, :battle_id, :generate_no], :class_name => "BattleInfo"
  belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
  belongs_to :party,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Party"
  belongs_to :status,  :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Status"
  has_many :equips,  :foreign_key => [:result_no, :e_no, :battle_id, :generate_no], :primary_key => [:result_no, :e_no, :battle_id, :generate_no], :class_name => "BattleEquip"
  belongs_to :equip_0,  -> { where(equip_no: 0)},  :foreign_key => [:result_no, :e_no, :battle_id, :generate_no], :primary_key => [:result_no, :e_no, :battle_id, :generate_no], :class_name => "BattleEquip"
  belongs_to :equip_1,  -> { where(equip_no: 1)},  :foreign_key => [:result_no, :e_no, :battle_id, :generate_no], :primary_key => [:result_no, :e_no, :battle_id, :generate_no], :class_name => "BattleEquip"
  belongs_to :equip_2,  -> { where(equip_no: 2)},  :foreign_key => [:result_no, :e_no, :battle_id, :generate_no], :primary_key => [:result_no, :e_no, :battle_id, :generate_no], :class_name => "BattleEquip"
  belongs_to :equip_3,  -> { where(equip_no: 3)},  :foreign_key => [:result_no, :e_no, :battle_id, :generate_no], :primary_key => [:result_no, :e_no, :battle_id, :generate_no], :class_name => "BattleEquip"
end
