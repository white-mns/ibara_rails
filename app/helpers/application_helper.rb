module ApplicationHelper
    def page_title
        title = "荊街データ小屋"
        title = @page_title + " | " + title if @page_title
        title
    end

    def pc_name_text(e_no, pc_name)
        capture_haml do
            e_no_text = "(" + sprintf("%d",e_no) + ")"
            if pc_name then
                haml_tag :div, class: "name_div" do
                    haml_concat pc_name.name
                end
            end
            haml_tag :span do
                haml_concat e_no_text
            end
        end
    end

    def character_link(e_no)
        if e_no <= 0 then return end

        file_name = sprintf("%d",e_no)
        link_to " 結果", "http://lisge.com/ib/k/now/r"+file_name+".html", :target => "_blank"
    end
    
    def character_old_link(latest_result_no, e_no, result_no, generate_no)
        if e_no <= 0 then return end
        if result_no == latest_result_no then return end

        result_no_text = sprintf("%d", result_no)
        file_name = sprintf("%d", e_no)
        link_to " "+result_no_text+":00", "http://lisge.com/ib/k/"+result_no_text+"/r"+file_name+".html", :target => "_blank"
    end

    def battle_link(latest_result_no, battle_type, battle_page, result_no, generate_no)
        if battle_page == "" then return end
        if result_no != latest_result_no then return end

        link_to " 結果", "http://lisge.com/ib/k/now/"+battle_page+".html", :target => "_blank"
    end
    
    def battle_old_link(latest_result_no, battle_type, battle_page, result_no, generate_no)
        if battle_page == "" then return end
        if result_no == latest_result_no then return end

        result_no_text = sprintf("%d", result_no)
        link_to " "+result_no_text+":00", "http://lisge.com/ib/k/"+result_no_text+"/"+battle_page+".html", :target => "_blank"
    end

    def search_submit_button()
        haml_tag :button, class: "btn submit", type: "submit" do
            haml_concat fa_icon "search", text: "検索する"
        end
    end

    def ex_sort_text(params, sort_column, text)
        if params["ex_sort"] == "on" && params["ex_sort_text"] && params["ex_sort_text"].include?(sort_column) then
            if params["ex_sort_text"].include?("desc")
                text = text + "▼"

            else
                text = text + "▲"
            end
        end
        text
    end

    def help_icon()
        haml_concat fa_icon "question-circle"
    end

    def act_desc(is_opened)
        desc        = is_opened ? "（クリックで閉じます）" : "（クリックで開きます）"
        desc_closed = is_opened ? "（クリックで開きます）" : "（クリックで閉じます）"

        haml_tag :span, class: "act_desc" do
            haml_concat desc
        end

        haml_tag :span, class: "act_desc closed" do
            haml_concat desc_closed
        end
    end

    def act_icon(is_opened)
        icon        = is_opened ? "times" : "plus"
        icon_closed = is_opened ? "plus"  : "times"

        haml_tag :span, class: "act_desc" do
            haml_concat fa_icon icon, class: "fa-lg"
        end

        haml_tag :span, class: "act_desc closed" do
            haml_concat fa_icon icon_closed, class: "fa-lg"
        end
    end

    def td_form(f, form_params, placeholders, class_name: nil, colspan: nil, label: nil, params_name: nil, placeholder: nil, checkboxes: nil, label_td_class_name: nil)
        haml_tag :td, class: label_td_class_name do
            if label then
                haml_concat f.label params_name.to_sym, label
            end
        end

        # テキストフォームの描画
        if !class_name.nil? && !params_name.nil?  then
            td_text_form(f, form_params, placeholders, class_name: class_name, colspan: colspan, params_name: params_name, placeholder: placeholder)
        end

        # チェックボックス選択フォームの描画
        if !checkboxes.nil?  then
            td_text_checkbox(f, form_params, placeholders, class_name: class_name, colspan: colspan, checkboxes: checkboxes)
        end
    end

    def td_text_form(f, form_params, placeholders, class_name: nil, colspan: nil, params_name: nil, placeholder: nil)
        haml_tag :td, class: class_name, colspan: colspan do
            haml_concat text_field_tag params_name.to_sym, form_params[params_name], placeholder: placeholders[placeholder]
        end
    end

    def td_text_checkbox(f, form_params, placeholders, class_name: nil, colspan: nil, checkboxes: [])
        haml_tag :td, class: class_name, colspan: colspan do
            checkboxes.each do |hash|
                # チェックボックスの描画
                if !hash[:params_name].nil? then
                    haml_tag :span, class: hash[:class_name] do
                        haml_concat check_box_tag hash[:params_name].to_sym, form_params[hash[:params_name]], form_params[hash[:params_name]]
                        haml_concat label_tag hash[:params_name].to_sym, hash[:label]
                    end
                end

                # 改行指定
                if hash[:br] then
                    haml_tag :br
                end
            end
        end
    end

    def tbody_toggle(form_params, params_name: nil, label: {open: "", close: ""}, act_desc: nil, base_first: false)
        haml_tag :tbody, class: "tbody_toggle pointer"do
            haml_tag :tr do
                haml_tag :td, colspan: 5 do
                    if base_first then
                        haml_concat hidden_field_tag :base_first, form_params["base_first"]
                    end

                    haml_concat hidden_field_tag params_name.to_sym, form_params[params_name]

                    act_icon(false)

                    haml_concat label_tag params_name.to_sym, "　" + label[:open],  class: "act_desc"
                    haml_concat label_tag params_name.to_sym, "　" + label[:close], class: "act_desc closed"
                    if act_desc then
                        haml_tag :div, class: "act_desc" do
                           haml_concat "　" + act_desc
                        end
                    end
                end
            end
        end
    end

    def all_assembly_text(assembly)
        if !assembly then
            return
        end

        assembly_text = ""

        assembly.each do |parts|
          assembly_text += parts.orig_name_name.name + "、" if parts.orig_name_name
        end

        assembly_text.chop()
    end

    def world_text(world)
        if !world then 
            return
        end

        if world.world == 0 then "イバラシティ"
        elsif world.world == 1 then "アンジニティ"
        else "？"
        end
    end

    def world_border(world)
        if !world then 
            return
        end

        border_style = ""
        if world.world == 0 then border_style = "0.2rem #080 solid"
        elsif world.world == 1 then border_style = "0.4rem #800 double"
        end

        "border-right: " + border_style;
    end

    def skill_type_text(skill)
        if !skill then 
            return
        end

        if skill.type_id == 0 then "A"
        elsif skill.type_id == 1 then "　P"
        else "？"
        end
    end

    def elemental_text(skill)
        if !skill then 
            return
        end

        if skill.element_id == 0 then "無"
        elsif skill.element_id == 1 then "火"
        elsif skill.element_id == 2 then "水"
        elsif skill.element_id == 3 then "風"
        elsif skill.element_id == 4 then "地"
        elsif skill.element_id == 5 then "光"
        elsif skill.element_id == 6 then "闇"
        end
    end

    def elemental_border(skill)
        if !skill then 
            return
        end

        border_style = ""
        if skill.element_id == 0 then return
        elsif skill.element_id == 1 then border_style = "0.2rem #c33 solid"
        elsif skill.element_id == 2 then border_style = "0.2rem #389 solid"
        elsif skill.element_id == 3 then border_style = "0.2rem #393 solid"
        elsif skill.element_id == 4 then border_style = "0.2rem #840 solid"
        elsif skill.element_id == 5 then border_style = "0.2rem #993 solid"
        elsif skill.element_id == 6 then border_style = "0.2rem #759 solid"
        end

        "border-left: " + border_style;
    end

    def party_type_text(party)
        if !party then 
            return
        end

        if party.party_type == 0 then "今回戦闘"
        elsif party.party_type == 1 then "次回予告"
        else "？"
        end
    end

    def party_members_pc_name_text(party_members)
        if !party_members then 
            return
        end

        party_members.each do |party_member|
            haml_concat pc_name_text(party_member.e_no, party_member.pc_name)
            haml_tag :br
        end
    end

    def enemy_members_text(members)
        if !members then 
            return
        end

        members.each do |member|
            haml_concat member.enemy.name
            haml_tag :br
        end
    end

    def party_members_move(party_members)
        if !party_members then 
            return
        end

        party_members.each do |party_member|
            if !party_member.move then
                break
            end

            party_member.move.each_with_index do |move, i|
                 landform_img_text(move)
                 if i < (party_member.move.length - 1) then
                    haml_concat "→"
                 end
            end

            haml_tag :br
        end
    end

    def style_img_text(style)
        if !style then 
            return
        end

        haml_tag :img, src: "https://archives.teiki.org/risu/ibara/0/p/si" + sprintf("%d", style.style_id) + ".png", class:"style_img"

        if style.style_id == 1 then haml_concat "瞬速"
        elsif style.style_id == 2 then haml_concat "疾駆"
        elsif style.style_id == 3 then haml_concat "強襲"
        elsif style.style_id == 4 then haml_concat "特攻"
        elsif style.style_id == 5 then haml_concat "順応"
        elsif style.style_id == 6 then haml_concat "堅固"
        elsif style.style_id == 7 then haml_concat "援助"
        elsif style.style_id == 8 then haml_concat "虎視"
        elsif style.style_id == 9 then haml_concat "日和"
        else haml_concat "？"
        end
    end

    def landform_img_text(landform)
        if !landform then 
            return
        end

        if landform.landform_id == 6 then
            haml_tag :img, src: "https://archives.teiki.org/risu/ibara/0/p/a" + sprintf("%d", 1) + ".png", class:"style_img"
        elsif landform.landform_id > 0 then
            haml_tag :img, src: "https://archives.teiki.org/risu/ibara/0/p/a" + sprintf("%d", landform.landform_id) + ".png", class:"style_img"
        end

        haml_concat landform_text(landform)
    end

    def landform_text(object)
        if !object then 
            return
        end

        if object.landform_id == 1 then "道路"
        elsif object.landform_id == 2 then "草原"
        elsif object.landform_id == 3 then "沼地"
        elsif object.landform_id == 4 then "森林"
        elsif object.landform_id == 5 then "山岳"
        elsif object.landform_id == 6 then "チェックポイント"
        else "？"
        end
    end


    def battle_type_text(object)
        if !object then 
            return
        end

        if object.battle_type == 0 then "ENCOUNTER"
        elsif object.battle_type == 1 then "MISSION"
        elsif object.battle_type == 10 then "DUEL"
        elsif object.battle_type == 11 then "GAME"
        elsif object.battle_type == 20 then "闘技大会"
        else "？"
        end
    end
end
