module CompoundHelper
  def compound_is_success_text(compound)
    if !compound then
      return
    end

    if compound.is_success == 1 then "合成"
    elsif compound.is_success == 2 then "合成実験"
    elsif compound.is_success == -1 then "Lv不足"
    elsif compound.is_success == -2 then "素材なし"
    else "？"
    end
  end
end
