class CookPassivesController < ApplicationController
  include MyUtility
  before_action :set_cook_passife, only: [:show, :edit, :update, :destroy]

  # GET /cook_passives
  def index
    resultno_set
    placeholder_set
    param_set

    @count	= CookPassive.notnil().includes(:pc_name, :world, :skill, [cook: [:pc_name, :world, :party, item: [:kind, :effect_1, :effect_2, :effect_3]]]).search(params[:q]).result.hit_count()
    @search	= CookPassive.notnil().includes(:pc_name, :world, :skill, [cook: [:pc_name, :world, :party, item: [:kind, :effect_1, :effect_2, :effect_3]]]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @cook_passives	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "requester_e_no", params_name: "requester_e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "cook_id", params_name: "cook_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "result", params_name: "result_form", type: "number")
    params_to_form(params, @form_params, column_name: "increase", params_name: "increase_form", type: "number")
    params_to_form(params, @form_params, column_name: "dice_total", params_name: "dice_total_form", type: "number")
    params_to_form(params, @form_params, column_name: "dice_1", params_name: "dice_1_form", type: "number")
    params_to_form(params, @form_params, column_name: "dice_2", params_name: "dice_2_form", type: "number")
    params_to_form(params, @form_params, column_name: "dice_3", params_name: "dice_3_form", type: "number")
    params_to_form(params, @form_params, column_name: "dice_4", params_name: "dice_4_form", type: "number")
    params_to_form(params, @form_params, column_name: "dice_5", params_name: "dice_5_form", type: "number")
    params_to_form(params, @form_params, column_name: "dice_6", params_name: "dice_6_form", type: "number")

    params_to_form(params, @form_params, column_name: "cook_pc_name_name", params_name: "cook_pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "cook_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "cook_name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "cook_source_name", params_name: "source_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")

    params_to_form(params, @form_params, column_name: "cook_item_strength", params_name: "strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "cook_addition_item_kind_name", params_name: "kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "cook_item_effect_1_name_or_cook_item_effect_2_name_or_cook_item_effect_3_name", params_name: "effect_form", type: "text")
    params_to_form(params, @form_params, column_name: "cook_item_effect_1_value", params_name: "effect_1_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "cook_item_effect_1_name", params_name: "effect_1_form", type: "text")
    params_to_form(params, @form_params, column_name: "cook_item_effect_2_value", params_name: "effect_2_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "cook_item_effect_2_name", params_name: "effect_2_form", type: "text")
    params_to_form(params, @form_params, column_name: "cook_item_effect_3_value", params_name: "effect_3_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "cook_item_effect_3_name", params_name: "effect_3_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "result_eq_any",
                             checkboxes: [{params_name: "dice_big_success", value: 2,  first_checked: false},
                                          {params_name: "dice_success"    , value: 1,  first_checked: false},
                                          {params_name: "dice_normal"     , value: 0,  first_checked: false},
                                          {params_name: "dice_failed"     , value: -1, first_checked: false},
                                          {params_name: "dice_big_failed" , value: -2, first_checked: false}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_dice")
    toggle_params_to_variable(params, @form_params, params_name: "show_source_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_item")
    toggle_params_to_variable(params, @form_params, params_name: "show_item_name")
  end
  # GET /cook_passives/1
  #def show
  #end

  # GET /cook_passives/new
  #def new
  #  @cook_passife = CookPassive.new
  #end

  # GET /cook_passives/1/edit
  #def edit
  #end

  # POST /cook_passives
  #def create
  #  @cook_passife = CookPassive.new(cook_passife_params)

  #  if @cook_passife.save
  #    redirect_to @cook_passife, notice: "Cook passive was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /cook_passives/1
  #def update
  #  if @cook_passife.update(cook_passife_params)
  #    redirect_to @cook_passife, notice: "Cook passive was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /cook_passives/1
  #def destroy
  #  @cook_passife.destroy
  #  redirect_to cook_passives_url, notice: "Cook passive was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cook_passife
      @cook_passife = CookPassive.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cook_passife_params
      params.require(:cook_passife).permit(:result_no, :generate_no, :requester_e_no, :cook_id, :skill_id, :result, :increase, :dice_total, :dice_1, :dice_2, :dice_3, :dice_4, :dice_5, :dice_6)
    end
end
