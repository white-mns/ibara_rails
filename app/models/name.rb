class Name < ApplicationRecord
	belongs_to :world,  :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "World"
	belongs_to :place,  :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Place"
	belongs_to :party,  :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Party"
	belongs_to :status, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Status"
	belongs_to :skill_concatenate, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "SkillConcatenate"


    # 所持異能・生産・スキル組み合わせ一覧用関連付け処理
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

    superpower_name = SuperpowerDatum.pluck(:name, :superpower_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}

    @superpower_datas.each do |superpower_data|
        belongs_to superpower_data[:en].to_sym,   -> { where(superpower_id: superpower_name[superpower_data[:jp]])},   :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Superpower"
    end

    def self.superpower_datas
        @superpower_datas
    end


    scope :combination_groups, ->(params) {
        group(:result_no).
        group(:e_no)
    }

    scope :combination_includes, ->(params, superpower_datas) {
        includes(:world, :skill_concatenate).
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
end
