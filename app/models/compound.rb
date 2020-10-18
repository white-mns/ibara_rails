class Compound < ApplicationRecord
    superpower_data = SuperpowerDatum.pluck(:name, :superpower_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    compound    = superpower_data["合成"]

	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
	belongs_to :compound,  -> { where(superpower_id: compound)}, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Superpower"
	belongs_to :compound_result, :foreign_key => :compound_result_id, :primary_key => :proper_id, :class_name => "ProperName"

    scope :compound_includes, ->(params) {
        if params["group_result"] == "on" || params["group_source"] then
            joins(:compound)
        else
            includes(:compound)
        end
    }

    scope :aggregations, ->(params) {
        if params["group_result"] == "on" || params["group_source"] then
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
