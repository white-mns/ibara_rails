class NewItemsController < ApplicationController
  include MyUtility
  before_action :set_new_item, only: [:show, :edit, :update, :destroy]

  # GET /new_items
  def index
    placeholder_set
    param_set
    @count	= NewItem.distinct.notnil().includes(item: [:kind, :effect_1, :effect_2, :effect_3]).search(params[:q]).result.hit_count()
    @search	= NewItem.distinct.notnil().includes(item: [:kind, :effect_1, :effect_2, :effect_3]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @new_items	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "number")

    params_to_form(params, @form_params, column_name: "item_strength", params_name: "strength_form", type: "number")
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

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_fuka")
  end
  # GET /new_items/1
  #def show
  #end

  # GET /new_items/new
  #def new
  #  @new_item = NewItem.new
  #end

  # GET /new_items/1/edit
  #def edit
  #end

  # POST /new_items
  #def create
  #  @new_item = NewItem.new(new_item_params)

  #  if @new_item.save
  #    redirect_to @new_item, notice: "New item was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_items/1
  #def update
  #  if @new_item.update(new_item_params)
  #    redirect_to @new_item, notice: "New item was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_items/1
  #def destroy
  #  @new_item.destroy
  #  redirect_to new_items_url, notice: "New item was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_item
      @new_item = NewItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_item_params
      params.require(:new_item).permit(:result_no, :generate_no, :name)
    end
end
