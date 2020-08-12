class BattleTargetsController < ApplicationController
  include MyUtility
  before_action :set_battle_target, only: [:show, :edit, :update, :destroy]

  # GET /battle_targets
  def index
    resultno_set
    placeholder_set
    param_set

    @count	= BattleTarget.notnil().includes(:battle_info, :pc_name, :world, :party, :enemy).search(params[:q]).result.hit_count()
    @search	= BattleTarget.notnil().includes(:battle_info, :pc_name, :world, :party, :enemy).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @battle_targets	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "battle_id", params_name: "battle_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "act_id", params_name: "act_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "act_sub_id", params_name: "act_sub_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "target_type", params_name: "target_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_id", params_name: "enemy_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "suffix_id", params_name: "suffix_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "enemy_name", params_name: "enemy_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "target_type_eq_any",
                             checkboxes: [{params_name: "target_pc",   value: 0, first_checked: true},
                                          {params_name: "target_npc" , value: 1, first_checked: false}])

    pm_matching(params, @form_params)

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
  end
  # GET /battle_targets/1
  #def show
  #end

  # GET /battle_targets/new
  #def new
  #  @battle_target = BattleTarget.new
  #end

  # GET /battle_targets/1/edit
  #def edit
  #end

  # POST /battle_targets
  #def create
  #  @battle_target = BattleTarget.new(battle_target_params)

  #  if @battle_target.save
  #    redirect_to @battle_target, notice: "Battle target was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /battle_targets/1
  #def update
  #  if @battle_target.update(battle_target_params)
  #    redirect_to @battle_target, notice: "Battle target was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /battle_targets/1
  #def destroy
  #  @battle_target.destroy
  #  redirect_to battle_targets_url, notice: "Battle target was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_target
      @battle_target = BattleTarget.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_target_params
      params.require(:battle_target).permit(:result_no, :generate_no, :battle_id, :act_id, :act_sub_id, :target_type, :e_no, :enemy_id, :suffix_id)
    end
end
