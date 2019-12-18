class NewBattleEnemiesController < ApplicationController
  include MyUtility
  before_action :set_new_battle_enemy, only: [:show, :edit, :update, :destroy]

  # GET /new_battle_enemies
  def index
    placeholder_set
    param_set
    @count	= NewBattleEnemy.notnil().includes(:enemy).search(params[:q]).result.hit_count()
    @search	= NewBattleEnemy.notnil().includes(:enemy).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @new_battle_enemies	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "enemy_id", params_name: "enemy_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "enemy_name", params_name: "enemy_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
  end
  # GET /new_battle_enemies/1
  #def show
  #end

  # GET /new_battle_enemies/new
  #def new
  #  @new_battle_enemy = NewBattleEnemy.new
  #end

  # GET /new_battle_enemies/1/edit
  #def edit
  #end

  # POST /new_battle_enemies
  #def create
  #  @new_battle_enemy = NewBattleEnemy.new(new_battle_enemy_params)

  #  if @new_battle_enemy.save
  #    redirect_to @new_battle_enemy, notice: "New battle enemy was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_battle_enemies/1
  #def update
  #  if @new_battle_enemy.update(new_battle_enemy_params)
  #    redirect_to @new_battle_enemy, notice: "New battle enemy was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_battle_enemies/1
  #def destroy
  #  @new_battle_enemy.destroy
  #  redirect_to new_battle_enemies_url, notice: "New battle enemy was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_battle_enemy
      @new_battle_enemy = NewBattleEnemy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_battle_enemy_params
      params.require(:new_battle_enemy).permit(:result_no, :generate_no, :enemy_id)
    end
end
