class BattleActionsController < ApplicationController
  include MyUtility
  before_action :set_battle_action, only: [:show, :edit, :update, :destroy]

  # GET /battle_actions
  def index
    placeholder_set
    param_set
    @count	= BattleAction.notnil().includes(:battle_info, :skill, :fuka).groups(params).search(params[:q]).result.hit_count()
    @search	= BattleAction.notnil().includes(:battle_info, :skill, :fuka).groups(params).total(params).includes_or_joins_and_total(params).having_order(params).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if params["group_page"] == "on" && @search.sorts.empty?
    @battle_actions	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
        params["group_page"]     ||= "on"
        params["total_use"]      ||= "on"
    end

    if params["group_page"] == "off" then
        params.delete("group_page")
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_id", params_name: "battle_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "turn", params_name: "turn_form", type: "number")
    params_to_form(params, @form_params, column_name: "act_id", params_name: "act_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "act_type", params_name: "act_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "fuka_id", params_name: "fuka_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "skill_name_or_fuka_name", params_name: "act_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_ep", params_name: "ep_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_text", params_name: "text_form", type: "text")


    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

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

    @form_params["group_turn"] = params["group_turn"]
    @form_params["group_page"] = params["group_page"]
    @form_params["total_use"]  = params["total_use"]
    @form_params["total_page"] = params["total_page"]

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_group")
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
