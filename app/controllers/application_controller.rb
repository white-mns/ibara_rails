class ApplicationController < ActionController::Base
  def resultno_set
    @latest_result = Name.maximum("result_no")
    @latest_generate = Name.where(result_no: @latest_result).maximum("generate_no")
    @uploaded_result = UploadedCheck.maximum("result_no")
  end

  def placeholder_set
    @placeholder = {}
    @placeholder["Number"]          = "例）1~10/50~100"
    @placeholder["Text"]            = "例）武器/\"防具\""
    @placeholder["Name"]            = "例）木村/\"鍛冶\""
    @placeholder["Skill"]           = "例）ブレイク/\"ヒール\""
    @placeholder["SkillName"]       = "つよブレイク/\"すごヒール\""
    @placeholder["SkillText"]       = "例）火撃 光撃"
    @placeholder["Item"]            = "例）不思議な食材"
    @placeholder["ItemKind"]        = "例）武器/素材/食材"
    @placeholder["Material"]        = "例）木材/石材"
    @placeholder["Fuka"]            = "例）活力/\"鎮痛\""
    @placeholder["Superpower"]      = "例）武術/合成"
    @placeholder["Timing"]          = "例）戦闘開始時"
    @placeholder["Field"]           = "例）チナミ/ヒノデ区"
    @placeholder["AreaColumn"]      = "例）A/b/c/d"
    @placeholder["Compound"]        = "例）どうでも/柔らか"
    @placeholder["Enemy"]           = "例）ナレハテ/\"ヤンキー\""
    @placeholder["EnemyNames"]      = "例）ハニワ 土偶"
    @placeholder["AideFuka"]        = "例）攻撃10 気合10"
    @placeholder["AideSkill"]       = "例）ブレイク 猛攻"
    @placeholder["AdditionPassive"] = "例）博打付加/付加強化"
    @placeholder["CookPassive"]     = "例）技巧料理/美酒佳肴"
  end
end
