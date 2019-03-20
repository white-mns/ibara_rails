module BattleDamageHelper
    def damage_type_text(object)
        if !object then 
            return
        end

        if object.damage_type == 0 then "回避"
        elsif object.damage_type == 1 then "ダメージ"
        elsif object.damage_type == 2 then "SPダメージ"
        elsif object.damage_type == 3 then "回復"
        elsif object.damage_type == 4 then "SP回復"
        else object.damage_type
        end
    end
end
