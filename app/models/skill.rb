class Skill < ApplicationRecord
    @superpower_datas = 
        [
            {en: "martial", jp: "武術"}, {en: "magic", jp: "魔術"},
            {en: "life", jp: "命術"}, {en: "spacetime", jp: "時空"},
            {en: "nature", jp: "自然"}, {en: "illusion", jp: "幻術"},
            {en: "curse", jp: "呪術"}, {en: "limitation", jp: "制約"},
            {en: "realization", jp: "具現"}, {en: "employ", jp: "使役"},
            {en: "change", jp: "変化"}, {en: "tinnitus", jp: "響鳴"},
            {en: "medicina", jp: "百薬"}, {en: "territory", jp: "領域"},
            {en: "analysis", jp: "解析"},
            {en: "weapon", jp: "武器"}, {en: "protector", jp: "防具"},
            {en: "ornament", jp: "装飾"}, {en: "annexation", jp: "付加"},
            {en: "composition", jp: "合成"}, {en: "cooking", jp: "料理"},
        ]

    proper_name = SuperpowerDatum.pluck(:name, :superpower_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}

	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :world,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
	belongs_to :place,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Place"
	belongs_to :party,   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Party"
	belongs_to :status,  :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Status"

	belongs_to :skill,         :foreign_key => :skill_id, :primary_key => :skill_id, :class_name => "SkillDatum"
	belongs_to :skill_mastery, :foreign_key => :skill_id, :primary_key => :skill_id, :class_name => "SkillMastery"

    @superpower_datas.each do |superpower_data|
        belongs_to superpower_data[:en].to_sym,   -> { where(superpower_id: proper_name[superpower_data[:jp]])},   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Superpower"
    end

    def self.superpower_datas
        @superpower_datas
    end

    scope :groups, ->(params) {
        if params["show_total"] then
            group("skills.result_no").
            group("skills.skill_id")
        end
    }
 
    scope :total, ->(params) {
        if params["show_total"] then
            select("*").
            select("COUNT(skills.id) AS user_count")
        end
    }

    scope :combination_groups, ->(params) {
        group(:result_no).
        group(:e_no)
    }

    scope :combination_includes, ->(params, superpower_datas) {
        includes(:world, :skill).
        includes([martial: [:place, :party]]).
        superpowers_includes(params, superpower_datas)
    }

    scope :superpowers_includes, ->(params, superpower_datas) {
        eval_text = ""
        superpower_datas.each do |superpower_data|
            eval_text += "includes(:" + superpower_data[:en] + ")."
        end
        eval(eval_text.chop)
    }

    scope :having_order, ->(params) {
        ex_sorts = {"user_count desc" => 1}
        if !params[:q][:s] then
            params["ex_sort_text"] = "user_count desc"
            return order("user_count desc")

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
