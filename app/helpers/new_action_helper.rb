module NewActionHelper
  def detail_new_action_link(object, data)
    if !object then
      return
    end

    action_name = ""

    if object.skill_id > 0 && object.skill then
      action_name = object.skill.name
    elsif object.fuka_id > 0 && object.fuka then
      action_name = object.fuka.name
    end

    title = data[action_name]
    title = title == " " ? "" : title

    span_attr = {data: {toggle: "tooltip"}, title: title}

    haml_tag :span, span_attr do
      haml_tag :a , href: battle_actions_path + "?result_no_form=" + sprintf("%d", object.result_no) + "&act_form= \"" + action_name + "\"&acter_npc=on" do
        haml_concat action_name
      end
    end
  end
end
