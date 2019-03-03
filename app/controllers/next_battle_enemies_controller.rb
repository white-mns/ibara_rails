class NextBattleEnemiesController < ApplicationController
  include MyUtility
  before_action :set_next_battle_enemy, only: [:show, :edit, :update, :destroy]

  # GET /next_battle_enemies
  def index
    placeholder_set
    param_set
    @count	= NextBattleEnemy.notnil().includes(:world, :enemy).search(params[:q]).result.count()
    @search	= NextBattleEnemy.notnil().includes(:world, :enemy).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @next_battle_enemies	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_no", params_name: "party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_type", params_name: "battle_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_id", params_name: "enemy_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "enemy_name", params_name: "enemy_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_type_eq_any",
                             checkboxes: [{params_name: "is_encounter", value: 0, first_checked: true},
                                          {params_name: "is_mission" ,  value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
  end
  # GET /next_battle_enemies/1
  #def show
  #end

  # GET /next_battle_enemies/new
  #def new
  #  @next_battle_enemy = NextBattleEnemy.new
  #end

  # GET /next_battle_enemies/1/edit
  #def edit
  #end

  # POST /next_battle_enemies
  #def create
  #  @next_battle_enemy = NextBattleEnemy.new(next_battle_enemy_params)

  #  if @next_battle_enemy.save
  #    redirect_to @next_battle_enemy, notice: "Next battle enemy was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /next_battle_enemies/1
  #def update
  #  if @next_battle_enemy.update(next_battle_enemy_params)
  #    redirect_to @next_battle_enemy, notice: "Next battle enemy was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /next_battle_enemies/1
  #def destroy
  #  @next_battle_enemy.destroy
  #  redirect_to next_battle_enemies_url, notice: "Next battle enemy was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_next_battle_enemy
      @next_battle_enemy = NextBattleEnemy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def next_battle_enemy_params
      params.require(:next_battle_enemy).permit(:result_no, :generate_no, :party_no, :battle_type, :enemy_id)
    end
end
