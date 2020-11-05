module NewItemHelper
  def detail_new_item_link(object)
    if !object then
        return
    end

    link_to object.name, items_path + "?result_no_form=" + sprintf("%d", object.result_no) + "&name_form=\"" + object.name + "\"&kind_form=\"素材\""
  end
end
