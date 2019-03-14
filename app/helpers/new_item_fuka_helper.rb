module NewItemFukaHelper
    def detail_new_item_fuka_link(object)
        if !object || !object.fuka then 
            return
        end

        link_to object.fuka.name, items_path + "?result_no_form=" + sprintf("%d", object.result_no) + "&effect_form= \"" + object.fuka.name + "\""
    end
end
