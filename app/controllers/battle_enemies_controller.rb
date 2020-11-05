class BattleEnemiesController < ApplicationController
  include MyUtility
  before_action :set_battle_enemy, only: [:show, :edit, :update, :destroy]

  # GET /battle_enemies
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = BattleEnemy.notnil().includes(:world, :enemy).search(params[:q]).result.hit_count()
    @search = BattleEnemy.notnil().includes(:world, :enemy).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @battle_enemies = @search.result.per(50)
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
  # GET /battle_enemies/1
  #def show
  #end

  # GET /battle_enemies/new
  #def new
  #  @battle_enemy = BattleEnemy.new
  #end

  # GET /battle_enemies/1/edit
  #def edit
  #end

  # POST /battle_enemies
  #def create
  #  @battle_enemy = BattleEnemy.new(battle_enemy_params)

  #  if @battle_enemy.save
  #    redirect_to @battle_enemy, notice: "Battle enemy was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /battle_enemies/1
  #def update
  #  if @battle_enemy.update(battle_enemy_params)
  #    redirect_to @battle_enemy, notice: "Battle enemy was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /battle_enemies/1
  #def destroy
  #  @battle_enemy.destroy
  #  redirect_to battle_enemies_url, notice: "Battle enemy was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_enemy
      @battle_enemy = BattleEnemy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_enemy_params
      params.require(:battle_enemy).permit(:result_no, :generate_no, :party_no, :battle_type, :enemy_id)
    end
end
