module NewBattleEnemyHelper
    def detail_new_battle_enemy_link(object)
        if !object || !object.enemy then 
            return
        end

        link_to object.enemy.name, battle_results_path + "?result_no_form=" + sprintf("%d", object.result_no) + "&enemy_form= \"" + object.enemy.name + "\""
    end
end
