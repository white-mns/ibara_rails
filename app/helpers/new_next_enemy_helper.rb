module NewNextEnemyHelper
    def detail_new_next_enemy_link(object)
        if !object || !object.enemy then 
            return
        end

        link_to object.enemy.name, next_battle_infos_path + "?result_no_form=" + sprintf("%d", object.result_no) + "&enemy_form= \"" + object.enemy.name + "\""
    end
end
