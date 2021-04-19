class BattleActer < ApplicationRecord
  belongs_to :battle_info, :foreign_key => [:result_no, :battle_id, :generate_no], :primary_key => [:result_no, :battle_id, :generate_no], :class_name => "BattleInfo"
  belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
  belongs_to :party,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Party"
  belongs_to :enemy,  :foreign_key => :enemy_id, :primary_key => :proper_id, :class_name => "ProperName"
  belongs_to :suffix, :foreign_key => :suffix_id, :primary_key => :proper_id, :class_name => "ProperName"
  belongs_to :status, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Status"
  has_many :equips,  :foreign_key => [:result_no, :e_no, :battle_id, :generate_no], :primary_key => [:result_no, :e_no, :battle_id, :generate_no], :class_name => "BattleEquip"
  belongs_to :equip_0,  -> { where(equip_no: 0)},  :foreign_key => [:result_no, :e_no, :battle_id, :generate_no], :primary_key => [:result_no, :e_no, :battle_id, :generate_no], :class_name => "BattleEquip"
  belongs_to :equip_1,  -> { where(equip_no: 1)},  :foreign_key => [:result_no, :e_no, :battle_id, :generate_no], :primary_key => [:result_no, :e_no, :battle_id, :generate_no], :class_name => "BattleEquip"
  belongs_to :equip_2,  -> { where(equip_no: 2)},  :foreign_key => [:result_no, :e_no, :battle_id, :generate_no], :primary_key => [:result_no, :e_no, :battle_id, :generate_no], :class_name => "BattleEquip"
  belongs_to :equip_3,  -> { where(equip_no: 3)},  :foreign_key => [:result_no, :e_no, :battle_id, :generate_no], :primary_key => [:result_no, :e_no, :battle_id, :generate_no], :class_name => "BattleEquip"
end
