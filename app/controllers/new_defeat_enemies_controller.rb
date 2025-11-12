class NewDefeatEnemiesController < ApplicationController
  include MyUtility
  before_action :set_new_defeat_enemy, only: [:show, :edit, :update, :destroy]

  # GET /new_defeat_enemies
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = NewDefeatEnemy.notnil().includes(:world, [party_info: [party_members: :pc_name]]).ransack(params[:q]).result.hit_count()
    @search = NewDefeatEnemy.notnil().includes(:world, [party_info: [party_members: :pc_name]]).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @new_defeat_enemies = @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "before_result_no", params_name: "before_result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "before_generate_no", params_name: "before_generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_no", params_name: "party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_id", params_name: "enemy_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "member_num", params_name: "member_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_type", params_name: "is_boss_form", type: "number")

    params_to_form(params, @form_params, column_name: "enemy_name", params_name: "enemy_form", type: "text")

    params_to_form(params, @form_params, column_name: "party_info_party_members_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_info_party_members_pc_name_name", params_name: "pc_name_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "member_num_eq_any",
                             checkboxes: [{params_name: "member_num_0", value: 0, first_checked: true},
                                          {params_name: "member_num_1", value: 1, first_checked: false},
                                          {params_name: "member_num_2", value: 2, first_checked: false},
                                          {params_name: "member_num_3", value: 3, first_checked: false},
                                          {params_name: "member_num_4", value: 4, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_type_eq_any",
                             checkboxes: [{params_name: "is_encounter", value: 0, first_checked: false},
                                          {params_name: "is_mission" ,  value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
  end
  # GET /new_defeat_enemies/1
  #def show
  #end

  # GET /new_defeat_enemies/new
  #def new
  #  @new_defeat_enemy = NewDefeatEnemy.new
  #end

  # GET /new_defeat_enemies/1/edit
  #def edit
  #end

  # POST /new_defeat_enemies
  #def create
  #  @new_defeat_enemy = NewDefeatEnemy.new(new_defeat_enemy_params)

  #  if @new_defeat_enemy.save
  #    redirect_to @new_defeat_enemy, notice: "New defeat enemy was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_defeat_enemies/1
  #def update
  #  if @new_defeat_enemy.update(new_defeat_enemy_params)
  #    redirect_to @new_defeat_enemy, notice: "New defeat enemy was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_defeat_enemies/1
  #def destroy
  #  @new_defeat_enemy.destroy
  #  redirect_to new_defeat_enemies_url, notice: "New defeat enemy was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_defeat_enemy
      @new_defeat_enemy = NewDefeatEnemy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_defeat_enemy_params
      params.require(:new_defeat_enemy).permit(:result_no, :generate_no, :before_result_no, :before_generate_no, :party_no, :enemy_id, :member_num, :battle_type)
    end
end
