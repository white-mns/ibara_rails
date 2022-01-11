class BattleUseSkillConcatenationsController < ApplicationController
  include MyUtility
  before_action :set_battle_use_skill_concatenation, only: [:show, :edit, :update, :destroy]

  # GET /battle_use_skill_concatenations
  def index
    resultno_set
    placeholder_set
    skill_data_set
    param_set

    @count  = BattleUseSkillConcatenation.notnil().includes(:pc_name, :world, :party, :equips, :equip_0, :equip_1, :equip_2, :equip_3).search(params[:q]).result.hit_count()
    @search = BattleUseSkillConcatenation.notnil().includes(:pc_name, :world, :party, :equips, :equip_0, :equip_1, :equip_2, :equip_3).page(params[:page]).search(params[:q])
    @search.sorts = "battle_id asc" if @search.sorts.empty?
    @battle_use_skill_concatenations = @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d", 36)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_id", params_name: "battle_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "concatenation_type", params_name: "concatenation_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "timing_type", params_name: "timing_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_concatenation", params_name: "skill_concatenation_form", type: "concat")

    params_to_form(params, @form_params, column_name: "equips_name", params_name: "equips_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "equips_effect_1_name_or_equips_effect_2_name_or_equips_effect_3_name", params_name: "equips_effect_form", type: "text")
    params_to_form(params, @form_params, column_name: "equip_0_kind_name", params_name: "equip_0_kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "equip_0_strength",  params_name: "equip_0_strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "equip_0_range",     params_name: "equip_0_range_form", type: "number")
    params_to_form(params, @form_params, column_name: "equip_1_kind_name", params_name: "equip_1_kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "equip_1_strength",  params_name: "equip_1_strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "equip_2_kind_name", params_name: "equip_2_kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "equip_2_strength",  params_name: "equip_2_strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "equip_3_kind_name", params_name: "equip_3_kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "equip_3_strength",  params_name: "equip_3_strength_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0},
                                          {params_name: "is_ansinity" , value: 1}])

    checkbox_params_set_query_any(params, @form_params, query_name: "concatenation_type_eq_any",
                             checkboxes: [{params_name: "concatenation_type_all", value: 0},
                                          {params_name: "concatenation_type_acter" , value: 1},
                                          {params_name: "concatenation_type_acter_lv_total" , value: 2}])

    checkbox_params_set_query_any(params, @form_params, query_name: "timing_type_eq_any",
                             checkboxes: [{params_name: "timing_type_all", value: 0},
                                          {params_name: "timing_type_start" , value: 1}])

    checkbox_params_set_query_any(params, @form_params, query_name: "status_style_id_eq_any",
                             checkboxes: [{params_name: "style_1", value: 1},
                                          {params_name: "style_2", value: 2},
                                          {params_name: "style_3", value: 3},
                                          {params_name: "style_4", value: 4},
                                          {params_name: "style_5", value: 5},
                                          {params_name: "style_6", value: 6},
                                          {params_name: "style_7", value: 7},
                                          {params_name: "style_8", value: 8},
                                          {params_name: "style_9", value: 9}])

    @form_params["skill_concatenation_bold"]   = params["skill_concatenation_bold"]
    @form_params["skill_concatenation_hidden"] = params["skill_concatenation_hidden"]
    @form_use_skill_texts  = ""
    @form_use_skill_texts += (@form_params["skill_concatenation_form"]) ? @form_params["skill_concatenation_form"] : "";

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_acter_detail")
  end
  # GET /battle_use_skill_concatenations/1
  #def show
  #end

  # GET /battle_use_skill_concatenations/new
  #def new
  #  @battle_use_skill_concatenation = BattleUseSkillConcatenation.new
  #end

  # GET /battle_use_skill_concatenations/1/edit
  #def edit
  #end

  # POST /battle_use_skill_concatenations
  #def create
  #  @battle_use_skill_concatenation = BattleUseSkillConcatenation.new(battle_use_skill_concatenation_params)

  #  if @battle_use_skill_concatenation.save
  #    redirect_to @battle_use_skill_concatenation, notice: "Battle use skill concatenation was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /battle_use_skill_concatenations/1
  #def update
  #  if @battle_use_skill_concatenation.update(battle_use_skill_concatenation_params)
  #    redirect_to @battle_use_skill_concatenation, notice: "Battle use skill concatenation was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /battle_use_skill_concatenations/1
  #def destroy
  #  @battle_use_skill_concatenation.destroy
  #  redirect_to battle_use_skill_concatenations_url, notice: "Battle use skill concatenation was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_use_skill_concatenation
      @battle_use_skill_concatenation = BattleUseSkillConcatenation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_use_skill_concatenation_params
      params.require(:battle_use_skill_concatenation).permit(:result_no, :generate_no, :battle_id, :concatenation_type, :timing_type, :e_no, :skill_concatenation)
    end
end
