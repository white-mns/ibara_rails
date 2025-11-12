class Compound < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

  superpower_data = SuperpowerDatum.pluck(:name, :superpower_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
  compound    = superpower_data["合成"]

  belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
  belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
  belongs_to :equipment_data, :foreign_key => [:result_no, :requester_e_no, :source_1_i_no, :generate_no], :primary_key => [:result_no, :e_no, :i_no, :generate_no], :class_name => "Item"
  belongs_to :compound,  -> { where(superpower_id: compound)}, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Superpower"
  belongs_to :compound_result, :foreign_key => :compound_result_id, :primary_key => :proper_id, :class_name => "ProperName"

  scope :associations, ->(params) {
    compound_includes(params).
    equipment_data_includes(params)
  }

  scope :compound_includes, ->(params) {
    if params["group_result"] == "on" || params["group_source"] == "on" then
      joins(:compound)
    else
      includes(:compound)
    end
  }

  scope :equipment_data_includes, ->(params) {
    includes(:equipment_data)
  }


  scope :aggregations, ->(params) {
    if params["group_result"] == "on" || params["group_source"] == "on" then
      select("*").
      select("MAX(CASE WHEN compounds.is_success < 0 THEN superpowers.lv ELSE null END) AS failed_max,
              MIN(CASE WHEN compounds.is_success > 0 THEN superpowers.lv ELSE null END) AS success_min")
    end
  }

  scope :groups, ->(params) {
    group_source(params).
    group_result(params).
    group_id(params)
  }

  scope :group_source, ->(params) {
    if params["group_source"] == "on" then
      group("compounds.sources_name")
    end
  }

  scope :group_result, ->(params) {
    if params["group_result"] == "on" then
      group("compounds.compound_result_id")
    end
  }

  scope :group_id, ->(params) {
    if params["group_result"] != "on" && params["group_source"] != "on" then
      group("compounds.id")
    end
  }

end
