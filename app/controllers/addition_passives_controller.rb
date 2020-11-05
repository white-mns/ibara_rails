class AdditionPassivesController < ApplicationController
  include MyUtility
  before_action :set_addition_passife, only: [:show, :edit, :update, :destroy]

  # GET /addition_passives
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = AdditionPassive.notnil().includes(:pc_name, :world, :skill, [addition: [:pc_name, :world, :party, item: [:kind, :effect_1, :effect_2, :effect_3]]]).search(params[:q]).result.hit_count()
    @search = AdditionPassive.notnil().includes(:pc_name, :world, :skill, [addition: [:pc_name, :world, :party, item: [:kind, :effect_1, :effect_2, :effect_3]]]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @addition_passives = @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "addition_id", params_name: "addition_id_form", type: "number")
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

    params_to_form(params, @form_params, column_name: "addition_pc_name_name", params_name: "addition_pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "addition_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")

    params_to_form(params, @form_params, column_name: "addition_addition_name", params_name: "addition_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "addition_target_name", params_name: "target_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "addition_item_strength", params_name: "strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "addition_item_kind_name", params_name: "kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "addition_item_effect_1_name_or_addition_item_effect_2_name_or_addition_item_effect_3_name", params_name: "effect_form", type: "text")
    params_to_form(params, @form_params, column_name: "addition_item_effect_1_value", params_name: "effect_1_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "addition_item_effect_1_name", params_name: "effect_1_form", type: "text")
    params_to_form(params, @form_params, column_name: "addition_item_effect_2_value", params_name: "effect_2_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "addition_item_effect_2_name", params_name: "effect_2_form", type: "text")
    params_to_form(params, @form_params, column_name: "addition_item_effect_3_value", params_name: "effect_3_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "addition_item_effect_3_name", params_name: "effect_3_form", type: "text")

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
    toggle_params_to_variable(params, @form_params, params_name: "show_item")
    toggle_params_to_variable(params, @form_params, params_name: "show_addition_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_target_name")
  end
  # GET /addition_passives/1
  #def show
  #end

  # GET /addition_passives/new
  #def new
  #  @addition_passife = AdditionPassive.new
  #end

  # GET /addition_passives/1/edit
  #def edit
  #end

  # POST /addition_passives
  #def create
  #  @addition_passife = AdditionPassive.new(addition_passife_params)

  #  if @addition_passife.save
  #    redirect_to @addition_passife, notice: "Addition passive was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /addition_passives/1
  #def update
  #  if @addition_passife.update(addition_passife_params)
  #    redirect_to @addition_passife, notice: "Addition passive was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /addition_passives/1
  #def destroy
  #  @addition_passife.destroy
  #  redirect_to addition_passives_url, notice: "Addition passive was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_addition_passife
      @addition_passife = AdditionPassive.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def addition_passife_params
      params.require(:addition_passife).permit(:result_no, :generate_no, :requester_e_no, :addition_id, :skill_id, :result, :increase, :dice_total, :dice_1, :dice_2, :dice_3, :dice_4, :dice_5, :dice_6)
    end
end
