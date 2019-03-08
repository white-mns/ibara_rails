class BattleActersController < ApplicationController
  include MyUtility
  before_action :set_battle_acter, only: [:show, :edit, :update, :destroy]

  # GET /battle_acters
  def index
    placeholder_set
    param_set
    @count	= BattleActer.notnil().includes(:battle_info, :pc_name, :world, :party, :enemy).search(params[:q]).result.hit_count()
    @search	= BattleActer.notnil().includes(:battle_info, :pc_name, :world, :party, :enemy).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @battle_acters	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "acter_type", params_name: "acter_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_id", params_name: "enemy_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "suffix_id", params_name: "suffix_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "enemy_name", params_name: "enemy_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0},
                                          {params_name: "is_ansinity" , value: 1}])

    checkbox_params_set_query_any(params, @form_params, query_name: "acter_type_eq_any",
                             checkboxes: [{params_name: "acter_pc",   value: 0, first_checked: true},
                                          {params_name: "acter_npc" , value: 1, first_checked: false}])

    pm_matching(params, @form_params)

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
  end
  # GET /battle_acters/1
  #def show
  #end

  # GET /battle_acters/new
  #def new
  #  @battle_acter = BattleActer.new
  #end

  # GET /battle_acters/1/edit
  #def edit
  #end

  # POST /battle_acters
  #def create
  #  @battle_acter = BattleActer.new(battle_acter_params)

  #  if @battle_acter.save
  #    redirect_to @battle_acter, notice: "Battle acter was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /battle_acters/1
  #def update
  #  if @battle_acter.update(battle_acter_params)
  #    redirect_to @battle_acter, notice: "Battle acter was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /battle_acters/1
  #def destroy
  #  @battle_acter.destroy
  #  redirect_to battle_acters_url, notice: "Battle acter was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_acter
      @battle_acter = BattleActer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_acter_params
      params.require(:battle_acter).permit(:result_no, :generate_no, :battle_id, :act_id, :acter_type, :e_no, :enemy_id, :suffix_id)
    end
end
