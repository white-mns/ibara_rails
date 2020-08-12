class BattleInfosController < ApplicationController
  include MyUtility
  before_action :set_battle_info, only: [:show, :edit, :update, :destroy]

  # GET /battle_infos
  def index
    resultno_set
    placeholder_set
    param_set

    @count	= BattleInfo.notnil().search(params[:q]).result.hit_count()
    @search	= BattleInfo.notnil().page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @battle_infos	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "battle_page", params_name: "battle_page_form", type: "text")
    params_to_form(params, @form_params, column_name: "battle_type", params_name: "battle_type_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_type_eq_any",
                             checkboxes: [{params_name: "is_encounter",  value: 0,  first_checked: false},
                                          {params_name: "is_mission",    value: 1,  first_checked: false},
                                          {params_name: "is_duel",       value: 10, first_checked: false},
                                          {params_name: "is_game",       value: 11, first_checked: false},
                                          {params_name: "is_tournament", value: 20, first_checked: false}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
  end
  # GET /battle_infos/1
  #def show
  #end

  # GET /battle_infos/new
  #def new
  #  @battle_info = BattleInfo.new
  #end

  # GET /battle_infos/1/edit
  #def edit
  #end

  # POST /battle_infos
  #def create
  #  @battle_info = BattleInfo.new(battle_info_params)

  #  if @battle_info.save
  #    redirect_to @battle_info, notice: "Battle info was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /battle_infos/1
  #def update
  #  if @battle_info.update(battle_info_params)
  #    redirect_to @battle_info, notice: "Battle info was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /battle_infos/1
  #def destroy
  #  @battle_info.destroy
  #  redirect_to battle_infos_url, notice: "Battle info was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_info
      @battle_info = BattleInfo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_info_params
      params.require(:battle_info).permit(:result_no, :generate_no, :battle_id, :battle_page, :battle_type)
    end
end
