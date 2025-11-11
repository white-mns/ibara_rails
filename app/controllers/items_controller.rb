class ItemsController < ApplicationController
  include MyUtility
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  def index
    placeholder_set
    param_set
    @count	= Item.distinct.notnil().includes(:pc_name, :world, :kind, :effect_1, :effect_2, :effect_3, :place, :party).ransack(params[:q]).result.hit_count()
    @search	= Item.distinct.notnil().includes(:pc_name, :world, :kind, :effect_1, :effect_2, :effect_3, :place, :party).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @items	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    if params["area_column_form"] then
        params["area_column_form"].upcase!
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "i_no", params_name: "i_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "kind_id", params_name: "kind_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "strength", params_name: "strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "range", params_name: "range_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_1_id", params_name: "effect_1_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_1_value", params_name: "effect_1_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_1_need_lv", params_name: "effect_1_need_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_2_id", params_name: "effect_2_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_2_value", params_name: "effect_2_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_2_need_lv", params_name: "effect_2_need_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_3_id", params_name: "effect_3_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_3_value", params_name: "effect_3_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_3_need_lv", params_name: "effect_3_need_lv_form", type: "number")

    params_to_form(params, @form_params, column_name: "kind_name", params_name: "kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "effect_1_name_or_effect_2_name_or_effect_3_name", params_name: "effect_form", type: "text")
    params_to_form(params, @form_params, column_name: "effect_1_name", params_name: "effect_1_form", type: "text")
    params_to_form(params, @form_params, column_name: "effect_2_name", params_name: "effect_2_form", type: "text")
    params_to_form(params, @form_params, column_name: "effect_3_name", params_name: "effect_3_form", type: "text")

    params_to_form(params, @form_params, column_name: "place_area_column", params_name: "area_column_form", type: "text")
    params_to_form(params, @form_params, column_name: "place_area_row", params_name: "area_row_form", type: "number")
    params_to_form(params, @form_params, column_name: "place_field_name", params_name: "field_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    girth_matching(params, @form_params)
    pm_matching(params, @form_params)
   
    # toggle操作用
    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
    toggle_params_to_variable(params, @form_params, params_name: "show_fuka")
  end
  # GET /items/1
  #def show
  #end

  # GET /items/new
  #def new
  #  @item = Item.new
  #end

  # GET /items/1/edit
  #def edit
  #end

  # POST /items
  #def create
  #  @item = Item.new(item_params)

  #  if @item.save
  #    redirect_to @item, notice: "Item was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /items/1
  #def update
  #  if @item.update(item_params)
  #    redirect_to @item, notice: "Item was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /items/1
  #def destroy
  #  @item.destroy
  #  redirect_to items_url, notice: "Item was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:result_no, :generate_no, :e_no, :i_no, :name, :kind_id, :strength, :range, :effect_1_id, :effect_1_value, :effect_1_need_lv, :effect_2_id, :effect_2_value, :effect_2_need_lv, :effect_3_id, :effect_3_value, :effect_3_need_lv)
    end
end
