class CooksController < ApplicationController
  include MyUtility
  before_action :set_cook, only: [:show, :edit, :update, :destroy]

  # GET /cooks
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = Cook.notnil().includes(:pc_name, :world, :requester, :party, [item: [:kind, :effect_1, :effect_2, :effect_3]]).search(params[:q]).result.hit_count()
    @search = Cook.notnil().includes(:pc_name, :world, :requester, :party, [item: [:kind, :effect_1, :effect_2, :effect_3]]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @cooks  = @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "requester_e_no", params_name: "requester_e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "cook_id", params_name: "cook_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "last_result_no", params_name: "last_result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "last_generate_no", params_name: "last_generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "i_no", params_name: "i_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "source_name", params_name: "source_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")

    params_to_form(params, @form_params, column_name: "item_strength", params_name: "strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_kind_name", params_name: "kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_1_name_or_item_effect_2_name_or_item_effect_3_name", params_name: "effect_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_1_value", params_name: "effect_1_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_1_name", params_name: "effect_1_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_2_value", params_name: "effect_2_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_2_name", params_name: "effect_2_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_3_value", params_name: "effect_3_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_3_name", params_name: "effect_3_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_fuka")
  end
  # GET /cooks/1
  #def show
  #end

  # GET /cooks/new
  #def new
  #  @cook = Cook.new
  #end

  # GET /cooks/1/edit
  #def edit
  #end

  # POST /cooks
  #def create
  #  @cook = Cook.new(cook_params)

  #  if @cook.save
  #    redirect_to @cook, notice: "Cook was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /cooks/1
  #def update
  #  if @cook.update(cook_params)
  #    redirect_to @cook, notice: "Cook was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /cooks/1
  #def destroy
  #  @cook.destroy
  #  redirect_to cooks_url, notice: "Cook was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cook
      @cook = Cook.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cook_params
      params.require(:cook).permit(:result_no, :generate_no, :e_no, :requester_e_no, :cook_id, :last_result_no, :last_generate_no, :i_no, :source_name, :name)
    end
end
