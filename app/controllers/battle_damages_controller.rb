class BattleDamagesController < ApplicationController
  include MyUtility
  before_action :set_battle_damage, only: [:show, :edit, :update, :destroy]

  # GET /battle_damages
  def index
    placeholder_set
    param_set
    @count	= BattleDamage.notnil().includes_or_joins(params).search(params[:q]).result.hit_count()
    @search	= BattleDamage.notnil().includes_or_joins(params).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @battle_damages	= @search.result.per(50)
  end

  # GET /b_rank/singles
  def single
    index
  end

  # GET /b_rank/totals
  def total
    placeholder_set
    param_set
    @count	= BattleDamage.notnil().includes_or_joins(params).groups(params).search(params[:q]).result.hit_count()
    @search	= BattleDamage.notnil().includes_or_joins(params).groups(params).total(params).having_order(params).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty? && params["ex_sort"] != "on"
    @battle_damages	= @search.result.per(50)
  end

  # GET /b_rank/pt_totals
  def pt_total
    placeholder_set
    param_set
    @count	= BattleDamage.notnil().includes_or_joins(params).pt_groups(params).search(params[:q]).result.hit_count()
    @search	= BattleDamage.notnil().includes_or_joins(params).pt_groups(params).total(params).having_order(params).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty? && params["ex_sort"] != "on"
    @battle_damages	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    link_sort

    if action_name == "total" then
        params[:q]["target_e_no_not_eq"] = -1
    end

    if action_name == "pt_total" then
        params[:q]["battle_info_battle_type_not_eq"] = -1
        params[:q]["target_party_party_type_eq"] = 1
        params[:q]["target_party_party_no_not_eq"] = 0
    end

    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_id", params_name: "battle_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "act_id", params_name: "act_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "act_sub_id", params_name: "act_sub_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "damage_type", params_name: "damage_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "element_id", params_name: "element_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "value", params_name: "value_form", type: "number")

    params_to_form(params, @form_params, column_name: "battle_info_battle_page", params_name: "battle_page_form", type: "text")

    params_to_form(params, @form_params, column_name: "battle_action_skill_name_or_battle_action_fuka_name", params_name: "act_form", type: "text")
    params_to_form(params, @form_params, column_name: "battle_action_skill_ep", params_name: "ep_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_action_skill_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_action_skill_text", params_name: "text_form", type: "text")

    params_to_form(params, @form_params, column_name: "battle_action_acter_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_action_acter_pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "battle_action_acter_enemy_name", params_name: "enemy_form", type: "text")

    params_to_form(params, @form_params, column_name: "target_e_no", params_name: "target_e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "target_pc_name_name", params_name: "target_pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "target_enemy_name", params_name: "target_enemy_form", type: "text")

    params_to_form(params, @form_params, column_name: "critical_value", params_name: "critical_form", type: "number")

    params_to_form(params, @form_params, column_name: "protection_value", params_name: "protection_form", type: "number")
    checkbox_params_set_query_single(params, @form_params, checkbox: {params_name: "no_protection", query_name:"protection_value_blank", value: true})
    params_to_form(params, @form_params, column_name: "reflection_value", params_name: "reflection_form", type: "number")
    checkbox_params_set_query_single(params, @form_params, checkbox: {params_name: "no_reflection", query_name:"reflection_value_blank", value: true})

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_action_acter_world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: false},
                                          {params_name: "is_ansinity" , value: 1, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "target_world_world_eq_any",
                             checkboxes: [{params_name: "target_ibaracity", value: 0, first_checked: false},
                                          {params_name: "target_ansinity" , value: 1, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "damage_type_eq_any",
                             checkboxes: [{params_name: "damage_type_dodge",     value: 0, first_checked: false},
                                          {params_name: "damage_type_damage",    value: 1, first_checked: false},
                                          {params_name: "damage_type_sp_damage", value: 2, first_checked: false},
                                          {params_name: "damage_type_heal",      value: 3, first_checked: false},
                                          {params_name: "damage_type_sp_heal",   value: 4, first_checked: false},
                                          {params_name: "damage_type_dodge_protection",   value: 5, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_action_act_type_eq_any",
                             checkboxes: [{params_name: "act_type_normal", value: 0},
                                          {params_name: "act_type_skill",  value: 1},
                                          {params_name: "act_type_fuka",   value: 2}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_info_battle_type_eq_any",
                             checkboxes: [{params_name: "is_encounter",  value: 0,  first_checked: false},
                                          {params_name: "is_mission",    value: 1,  first_checked: false},
                                          {params_name: "is_duel",       value: 10, first_checked: false},
                                          {params_name: "is_game",       value: 11, first_checked: false},
                                          {params_name: "is_tournament", value: 20, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_action_acter_acter_type_eq_any",
                             checkboxes: [{params_name: "acter_pc",   value: 0, first_checked: false},
                                          {params_name: "acter_npc" , value: 1, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "target_target_type_eq_any",
                             checkboxes: [{params_name: "target_pc",   value: 0, first_checked: false},
                                          {params_name: "target_npc" , value: 1, first_checked: false}])

    @form_params["ex_sort"] = params["ex_sort"]
    
    acter_pm_matching(params, @form_params)
    target_pm_matching(params, @form_params)

    if !params["is_form"] && params["ex_sort"] == "on" then
        params["is_form"] = 1
    end

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_fuka")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
    toggle_params_to_variable(params, @form_params, params_name: "show_battle_page")
    toggle_params_to_variable(params, @form_params, params_name: "show_acter")
    toggle_params_to_variable(params, @form_params, params_name: "show_target")
    toggle_params_to_variable(params, @form_params, params_name: "show_acter_pt")
    toggle_params_to_variable(params, @form_params, params_name: "show_target_pt")
    toggle_params_to_variable(params, @form_params, params_name: "show_group")
    toggle_params_to_variable(params, @form_params, params_name: "show_damage")
    toggle_params_to_variable(params, @form_params, params_name: "show_critical")
    toggle_params_to_variable(params, @form_params, params_name: "show_dodge")
    toggle_params_to_variable(params, @form_params, params_name: "show_prot_refl")
    
  end

  def link_sort
    if params["sort_damage"] == "on" then
        params[:q][:s] ||= "value desc"
    end

    if params["sort_critical"] == "on" then
        params[:q][:s] ||= "critical_value desc"
    end

    if params["sort_total_dodge"] == "on" then
        params[:q][:s] ||= "dodge_count desc"
    end
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
          if params[:q]["battle_action_acter_e_no_eq_any"] then
            params[:q]["battle_action_acter_e_no_eq_any"] = params[:q]["battle_action_acter_e_no_eq_any"].push(party_member_array).flatten

          else
            params[:q]["battle_action_acter_e_no_eq_any"] = party_member_array
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

  # 対象キャラ周囲絞り込み用
  def target_pm_matching(params, form_params)
      if !params["is_form"] then
          params["target_pm_result_no_form"] ||= sprintf("%d",@latest_result)
      end

      params_tmp = {}
      params_tmp[:q] = {}
      params_tmp["is_form"] = "1"
      params_tmp["target_pm_result_no_form"] = params["target_pm_result_no_form"]
      params_tmp["target_pm_e_no_form"] = params["target_pm_e_no_form"]
      params_tmp["target_pm_pc_name_form"] = params["target_pm_pc_name_form"]
      params_tmp["target_pm_party_type_form"] = params["target_pm_party_type_form"]
      params_tmp["target_pm_battle"] = params["target_pm_battle"]
      params_tmp["target_pm_next"]   = params["target_pm_next"]

      params_to_form(params_tmp, @form_params, column_name: "result_no", params_name: "target_pm_result_no_form", type: "number")
      params_to_form(params_tmp, @form_params, column_name: "e_no", params_name: "target_pm_e_no_form", type: "number")
      params_to_form(params_tmp, @form_params, column_name: "pc_name_name", params_name: "target_pm_pc_name_form", type: "text")
      checkbox_params_set_query_any(params_tmp, @form_params, query_name: "party_type_eq_any",
                               checkboxes: [{params_name: "target_pm_battle", value: 0, first_checked: false},
                                            {params_name: "target_pm_next" ,  value: 1, first_checked: true}])

      if params["target_pm_e_no_form"] || params["target_pm_pc_name_form"]
          party_member_array = Party.pc_to_party_member_array(params_tmp)
          if params[:q]["target_e_no_eq_any"] then
            params[:q]["target_e_no_eq_any"] = params[:q]["target_e_no_eq_any"].push(party_member_array).flatten

          else
            params[:q]["target_e_no_eq_any"] = party_member_array
          end

      end

      # フォームに値を受け渡す用の空実行
      checkbox_params_set_query_any(params, @form_params, query_name: "xxx",
                               checkboxes: [{params_name: "target_pm_battle", value: 0, first_checked: false},
                                            {params_name: "target_pm_next" ,  value: 1, first_checked: true}])

      form_params["target_pm_result_no_form"] = params["target_pm_result_no_form"]
      form_params["target_pm_e_no_form"]      = params["target_pm_e_no_form"]
      form_params["target_pm_pc_name_form"]   = params["target_pm_pc_name_form"]
      form_params["target_pm_battle"]         = params["target_pm_battle"]
      form_params["target_pm_next"]           = params["target_pm_next"]
  end


  # GET /battle_damages/1
  #def show
  #end

  # GET /battle_damages/new
  #def new
  #  @battle_damage = BattleDamage.new
  #end

  # GET /battle_damages/1/edit
  #def edit
  #end

  # POST /battle_damages
  #def create
  #  @battle_damage = BattleDamage.new(battle_damage_params)

  #  if @battle_damage.save
  #    redirect_to @battle_damage, notice: "Battle damage was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /battle_damages/1
  #def update
  #  if @battle_damage.update(battle_damage_params)
  #    redirect_to @battle_damage, notice: "Battle damage was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /battle_damages/1
  #def destroy
  #  @battle_damage.destroy
  #  redirect_to battle_damages_url, notice: "Battle damage was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_damage
      @battle_damage = BattleDamage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_damage_params
      params.require(:battle_damage).permit(:result_no, :generate_no, :battle_id, :act_id, :act_sub_id, :damage_type, :element_id, :value)
    end
end
