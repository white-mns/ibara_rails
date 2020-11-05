class DropItemsController < ApplicationController
  include MyUtility
  before_action :set_drop_item, only: [:show, :edit, :update, :destroy]

  # GET /drop_items
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = DropItem.notnil().includes(:pc_name, :world, :place, :party, item: [:world, :kind, :effect_1, :effect_2, :effect_3]).search(params[:q]).result.hit_count()
    @search = DropItem.notnil().includes(:pc_name, :world, :place, :party, item: [:world, :kind, :effect_1, :effect_2, :effect_3]).page(params[:page]).search(params[:q])
    if @search.sorts.empty? then
      @search.sorts = params["is_form"] ? "id asc" : "plus desc"
    end
    @drop_items = @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
      params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "plus", params_name: "plus_form", type: "number")

    params_to_form(params, @form_params, column_name: "item_strength", params_name: "strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_kind_name", params_name: "kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_1_value", params_name: "effect_1_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_1_need_lv", params_name: "effect_1_need_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_2_value", params_name: "effect_2_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_2_need_lv", params_name: "effect_2_need_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_3_value", params_name: "effect_3_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_3_need_lv", params_name: "effect_3_need_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_1_name_or_item_effect_2_name_or_item_effect_3_name", params_name: "effect_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_1_name", params_name: "effect_1_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_2_name", params_name: "effect_2_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_3_name", params_name: "effect_3_form", type: "text")

    params_to_form(params, @form_params, column_name: "place_area_column", params_name: "area_column_form", type: "text")
    params_to_form(params, @form_params, column_name: "place_area_row", params_name: "area_row_form", type: "number")
    params_to_form(params, @form_params, column_name: "place_field_name", params_name: "field_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    girth_matching(params, @form_params)
    pm_matching(params, @form_params)

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_item")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
    toggle_params_to_variable(params, @form_params, params_name: "show_fuka")
  end
  # GET /drop_items/1
  #def show
  #end

  # GET /drop_items/new
  #def new
  #  @drop_item = DropItem.new
  #end

  # GET /drop_items/1/edit
  #def edit
  #end

  # POST /drop_items
  #def create
  #  @drop_item = DropItem.new(drop_item_params)

  #  if @drop_item.save
  #    redirect_to @drop_item, notice: "Drop item was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /drop_items/1
  #def update
  #  if @drop_item.update(drop_item_params)
  #    redirect_to @drop_item, notice: "Drop item was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /drop_items/1
  #def destroy
  #  @drop_item.destroy
  #  redirect_to drop_items_url, notice: "Drop item was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drop_item
      @drop_item = DropItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def drop_item_params
      params.require(:drop_item).permit(:result_no, :generate_no, :e_no, :name, :plus)
    end
end
