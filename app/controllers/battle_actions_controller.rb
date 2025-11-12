class BattleActionsController < ApplicationController
  include MyUtility
  before_action :set_battle_action, only: [:show, :edit, :update, :destroy]

  # GET /battle_actions
  def index
    resultno_set
    placeholder_set
    skill_data_set
    param_set

    if params["no_result"] != "on" then
      if params["no_count"] != "on" then
        @count = BattleAction.notnil().includes_or_joins(params).groups(params).ransack(params[:q]).result.hit_count()
      end
      @search = BattleAction.notnil().includes_or_joins(params).groups(params).total(params).having_order(params).page(params[:page]).ransack(params[:q])
      @search.sorts = "id asc" if @search.sorts.empty? && params["ex_sort"] != "on"
      @battle_actions = @search.result.per(50)
    else
      @search = BattleAction.where(:result_no => -1).ransack(params[:q])
    end
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
      params["result_no_form"] ||= sprintf("%d", 36)
      params["group_page"]     ||= "on"
    end

    if params["group_page"] == "off" then
      params.delete("group_page")
    end

    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_id", params_name: "battle_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "turn", params_name: "turn_form", type: "number")
    params_to_form(params, @form_params, column_name: "act_id", params_name: "act_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "act_type", params_name: "act_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "fuka_id", params_name: "fuka_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "lv", params_name: "lv_form", type: "number")

    params_to_form(params, @form_params, column_name: "battle_info_battle_page", params_name: "battle_page_form", type: "text")

    params_to_form(params, @form_params, column_name: "skill_name_or_fuka_name", params_name: "act_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_ep", params_name: "ep_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_text", params_name: "text_form", type: "text")

    params_to_form(params, @form_params, column_name: "acter_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "acter_pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "acter_enemy_name", params_name: "enemy_form", type: "text")

    params_to_form(params, @form_params, column_name: "acter_equips_name", params_name: "acter_equips_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "acter_equips_effect_1_name_or_acter_equips_effect_2_name_or_acter_equips_effect_3_name", params_name: "acter_equips_effect_form", type: "text")
    params_to_form(params, @form_params, column_name: "acter_equip_0_kind_name", params_name: "acter_equip_0_kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "acter_equip_0_strength",  params_name: "acter_equip_0_strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "acter_equip_0_range",     params_name: "acter_equip_0_range_form", type: "number")
    params_to_form(params, @form_params, column_name: "acter_equip_1_kind_name", params_name: "acter_equip_1_kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "acter_equip_1_strength",  params_name: "acter_equip_1_strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "acter_equip_2_kind_name", params_name: "acter_equip_2_kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "acter_equip_2_strength",  params_name: "acter_equip_2_strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "acter_equip_3_kind_name", params_name: "acter_equip_3_kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "acter_equip_3_strength",  params_name: "acter_equip_3_strength_form", type: "number")

    params_to_form(params, @form_params, column_name: "acter_use_skill_all_all_skill_concatenation",   params_name: "use_skill_all_all_form",   type: "concat")
    params_to_form(params, @form_params, column_name: "acter_use_skill_all_start_skill_concatenation", params_name: "use_skill_all_start_form", type: "concat")
    params_to_form(params, @form_params, column_name: "acter_use_skill_acter_all_skill_concatenation",   params_name: "use_skill_acter_all_form",   type: "concat")
    params_to_form(params, @form_params, column_name: "acter_use_skill_acter_start_skill_concatenation", params_name: "use_skill_acter_start_form", type: "concat")
    params_to_form(params, @form_params, column_name: "acter_use_skill_acter_lv_total_start_skill_concatenation", params_name: "use_skill_acter_lv_total_start_form", type: "concat")

    checkbox_params_set_query_any(params, @form_params, query_name: "acter_world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: false},
                                          {params_name: "is_ansinity" , value: 1, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "act_type_eq_any",
                             checkboxes: [{params_name: "act_type_normal", value: 0},
                                          {params_name: "act_type_skill",  value: 1, first_checked: true},
                                          {params_name: "act_type_fuka",   value: 2, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_info_battle_type_eq_any",
                             checkboxes: [{params_name: "is_encounter",  value: 0,  first_checked: false},
                                          {params_name: "is_mission",    value: 1,  first_checked: false},
                                          {params_name: "is_duel",       value: 10, first_checked: false},
                                          {params_name: "is_game",       value: 11, first_checked: false},
                                          {params_name: "is_tournament", value: 20, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "acter_acter_type_eq_any",
                             checkboxes: [{params_name: "acter_pc",   value: 0, first_checked: true},
                                          {params_name: "acter_npc" , value: 1, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "acter_status_style_id_eq_any",
                             checkboxes: [{params_name: "style_1", value: 1},
                                          {params_name: "style_2", value: 2},
                                          {params_name: "style_3", value: 3},
                                          {params_name: "style_4", value: 4},
                                          {params_name: "style_5", value: 5},
                                          {params_name: "style_6", value: 6},
                                          {params_name: "style_7", value: 7},
                                          {params_name: "style_8", value: 8},
                                          {params_name: "style_9", value: 9}])


    acter_pm_matching(params, @form_params)
    pm_matching(params, @form_params)

    @form_params["group_turn"] = params["group_turn"]
    @form_params["group_page"] = params["group_page"]
    @form_params["group_acter"] = params["group_acter"]
    @form_params["total_act"]  = params["total_act"]
    @form_params["total_acter"] = params["total_acter"]
    @form_params["total_page"] = params["total_page"]
    @form_params["ex_sort"] = params["ex_sort"]
    @form_params["no_result"] = params["no_result"]
    @form_params["no_count"] = params["no_count"]

    @form_params["show_use_skill_all_all"] = params["show_use_skill_all_all"]
    @form_params["show_use_skill_all_start"] = params["show_use_skill_all_start"]
    @form_params["show_use_skill_acter_all"]   = params["show_use_skill_acter_all"]
    @form_params["show_use_skill_acter_start"] = params["show_use_skill_acter_start"]
    @form_params["show_use_skill_acter_lv_total_start"] = params["show_use_skill_acter_lv_total_start"]
    @form_params["skill_concatenation_bold"]   = params["skill_concatenation_bold"]
    @form_params["skill_concatenation_hidden"] = params["skill_concatenation_hidden"]
    @form_use_skill_texts  = ""
    @form_use_skill_texts += (@form_params["use_skill_all_all_form"]) ? " "+@form_params["use_skill_all_all_form"] : "";
    @form_use_skill_texts += (@form_params["use_skill_all_start_form"]) ? " "+@form_params["use_skill_all_start_form"] : "";
    @form_use_skill_texts += (@form_params["use_skill_acter_all_form"]) ? " "+@form_params["use_skill_acter_all_form"] : "";
    @form_use_skill_texts += (@form_params["use_skill_acter_start_form"]) ? " "+@form_params["use_skill_acter_start_form"] : "";
    @form_use_skill_texts += (@form_params["use_skill_acter_lv_total_start_form"]) ? " "+@form_params["use_skill_acter_lv_total_start_form"] : "";

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_fuka")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
    toggle_params_to_variable(params, @form_params, params_name: "show_battle_page")
    toggle_params_to_variable(params, @form_params, params_name: "show_acter")
    toggle_params_to_variable(params, @form_params, params_name: "show_acter_pt")
    toggle_params_to_variable(params, @form_params, params_name: "show_acter_detail")
    toggle_params_to_variable(params, @form_params, params_name: "show_group")
    toggle_params_to_variable(params, @form_params, params_name: "show_use_skill")
  end

  # 発動キャラ周囲絞り込み用
  def acter_pm_matching(params, form_params)
    if !params["is_form"] then
      params["acter_pm_result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_tmp = {}
    params_tmp[:q] = {}
    params_tmp["is_form"] = "1"
    params_tmp["acter_pm_result_no_form"] = params["acter_pm_result_no_form"]
    params_tmp["acter_pm_e_no_form"] = params["acter_pm_e_no_form"]
    params_tmp["acter_pm_pc_name_form"] = params["acter_pm_pc_name_form"]
    params_tmp["acter_pm_party_type_form"] = params["acter_pm_party_type_form"]
    params_tmp["acter_pm_battle"] = params["acter_pm_battle"]
    params_tmp["acter_pm_next"]   = params["acter_pm_next"]

    params_to_form(params_tmp, @form_params, column_name: "result_no", params_name: "acter_pm_result_no_form", type: "number")
    params_to_form(params_tmp, @form_params, column_name: "e_no", params_name: "acter_pm_e_no_form", type: "number")
    params_to_form(params_tmp, @form_params, column_name: "pc_name_name", params_name: "acter_pm_pc_name_form", type: "text")
    checkbox_params_set_query_any(params_tmp, @form_params, query_name: "party_type_eq_any",
                             checkboxes: [{params_name: "acter_pm_battle", value: 0, first_checked: false},
                                          {params_name: "acter_pm_next" ,  value: 1, first_checked: true}])

    if params["acter_pm_e_no_form"] || params["acter_pm_pc_name_form"]
      party_member_array = Party.pc_to_party_member_array(params_tmp)
      if params[:q]["acter_e_no_eq_any"] then
        params[:q]["acter_e_no_eq_any"] = params[:q]["acter_e_no_eq_any"].push(party_member_array).flatten

      else
        params[:q]["acter_e_no_eq_any"] = party_member_array
      end

    end

    # フォームに値を受け渡す用の空実行
    checkbox_params_set_query_any(params, @form_params, query_name: "xxx",
                             checkboxes: [{params_name: "acter_pm_battle", value: 0, first_checked: false},
                                          {params_name: "acter_pm_next" ,  value: 1, first_checked: true}])

    form_params["acter_pm_result_no_form"] = params["acter_pm_result_no_form"]
    form_params["acter_pm_e_no_form"]      = params["acter_pm_e_no_form"]
    form_params["acter_pm_pc_name_form"]   = params["acter_pm_pc_name_form"]
    form_params["acter_pm_battle"]         = params["acter_pm_battle"]
    form_params["acter_pm_next"]           = params["acter_pm_next"]
  end

  # GET /battle_actions/1
  #def show
  #end

  # GET /battle_actions/new
  #def new
  #  @battle_action = BattleAction.new
  #end

  # GET /battle_actions/1/edit
  #def edit
  #end

  # POST /battle_actions
  #def create
  #  @battle_action = BattleAction.new(battle_action_params)

  #  if @battle_action.save
  #    redirect_to @battle_action, notice: "Battle action was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /battle_actions/1
  #def update
  #  if @battle_action.update(battle_action_params)
  #    redirect_to @battle_action, notice: "Battle action was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /battle_actions/1
  #def destroy
  #  @battle_action.destroy
  #  redirect_to battle_actions_url, notice: "Battle action was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_action
      @battle_action = BattleAction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_action_params
      params.require(:battle_action).permit(:result_no, :generate_no, :battle_id, :turn, :act_id, :act_type, :skill_id, :fuka_id)
    end
end
