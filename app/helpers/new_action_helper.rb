module NewActionHelper
    def detail_new_action_link(object)
        if !object then 
            return
        end

        action_name = ""

        if object.skill_id > 0 && object.skill then
            action_name = object.skill.name
        elsif object.fuka_id > 0 && object.fuka then
            action_name = object.fuka.name
        end

        link_to action_name, battle_actions_path + "?result_no_form=" + sprintf("%d", object.result_no) + "&act_form= \"" + action_name + "\"&acter_npc=on"
    end
end
