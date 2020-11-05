module TopPageHelper
  def top_text(result_no, generate_no, uploaded)
    if !result_no then return "-" end
    generate_text = ""
    generate_text = "再" if generate_no > 0
    num = 2

    while num <= generate_no do
      num += 1
      generate_text += "再"
    end

    text = "第" + sprintf("%d", result_no) + "回" + generate_text

    if result_no == uploaded then
      text += "更新結果まで反映済です。"
    else
      text += "更新結果のデータに更新中です…"
    end

    text
  end
end
