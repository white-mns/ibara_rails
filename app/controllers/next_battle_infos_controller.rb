class NextBattleInfosController < ApplicationController
  include MyUtility
  before_action :set_next_battle_info, only: [:show, :edit, :update, :destroy]

  # GET /next_battle_infos
  def index
    placeholder_set
    param_set
    @count	= NextBattleInfo.distinct.notnil().includes(:world, :place, [party_info: [party_members: [:pc_name, :move]]], [enemy_members: :enemy], :road, :grass, :swamp, :forest, :mountain).ransack(params[:q]).result.count()
    @search	= NextBattleInfo.distinct.notnil().includes(:world, :place, [party_info: [party_members: [:pc_name, :move]]], [enemy_members: :enemy], :road, :grass, :swamp, :forest, :mountain).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @next_battle_infos	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "enemy_party_name_id", params_name: "enemy_party_name_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "party_info_member_num", params_name: "member_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "member_num", params_name: "enemy_member_num_form", type: "number")

    params_to_form(params, @form_params, column_name: "party_info_party_members_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_info_party_members_pc_name_name", params_name: "pc_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "enemy_party_name_name", params_name: "enemy_party_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "party_info_name", params_name: "party_name_form", type: "text")
    
    params_to_form(params, @form_params, column_name: "enemy_members_enemy_dummy", params_name: "enemy_form", type: "text")

    detection_party_no_from_enemy_name(params, @form_params)

    params_to_form(params, @form_params, column_name: "road_move_count",     params_name: "road_form",     type: "number")
    params_to_form(params, @form_params, column_name: "grass_move_count",    params_name: "grass_form",    type: "number")
    params_to_form(params, @form_params, column_name: "swamp_move_count",    params_name: "swamp_form",    type: "number")
    params_to_form(params, @form_params, column_name: "forest_move_count",   params_name: "forest_form",   type: "number")
    params_to_form(params, @form_params, column_name: "mountain_move_count", params_name: "mountain_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_type_eq_any",
                             checkboxes: [{params_name: "is_encounter", value: 0, first_checked: true},
                                          {params_name: "is_mission" ,  value: 1, first_checked: true}])


    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_member_num")
    toggle_params_to_variable(params, @form_params, params_name: "show_party_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_move")
    toggle_params_to_variable(params, @form_params, params_name: "show_move_statistics")
  end

  def detection_party_no_from_enemy_name(params, form_params)
    params_tmp = {}
    params_tmp[:q] = {}
    params_tmp["result_no_form"] = params["result_no_form"]
    params_tmp["party_no_form"]  = params["party_no_form"]
    params_to_form(params_tmp, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params_tmp, @form_params, column_name: "party_no",  params_name: "party_no_form", type: "number")

    detection_arrays = {and: [], or: [], not: []}

    add_and_param_for_has_many(params, params_tmp, detection_arrays, "enemy_members_enemy_dummy_cont_all",     "enemy_name_cont_all", NextBattleEnemy.includes(:enemy), :party_no)
    add_and_param_for_has_many(params, params_tmp, detection_arrays, "enemy_members_enemy_dummy_eq_all",       "enemy_name_eq_all",   NextBattleEnemy.includes(:enemy), :party_no)
    add_or_param_for_has_many( params, params_tmp, detection_arrays, "enemy_members_enemy_dummy_cont_any",     "enemy_name_cont_any", NextBattleEnemy.includes(:enemy), :party_no)
    add_or_param_for_has_many( params, params_tmp, detection_arrays, "enemy_members_enemy_dummy_eq_any",       "enemy_name_eq_any",   NextBattleEnemy.includes(:enemy), :party_no)
    add_not_param_for_has_many(params, params_tmp, detection_arrays, "enemy_members_enemy_dummy_not_cont_all", "enemy_name_cont_all", NextBattleEnemy.includes(:enemy), :party_no)
    add_not_param_for_has_many(params, params_tmp, detection_arrays, "enemy_members_enemy_dummy_not_eq_all",   "enemy_name_eq_all",   NextBattleEnemy.includes(:enemy), :party_no)

    params[:q]["party_no_eq_any"] = detection_arrays[:or].flatten.uniq

    if params[:q]["party_no_eq_any"].length > 1 then 
        params[:q]["party_no_eq_any"] += detection_arrays[:or].flatten.uniq
        params[:q]["party_no_eq_any"] = params[:q]["party_no_eq_any"].flatten.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)
    else
        params[:q]["party_no_eq_any"] = detection_arrays[:and].flatten.uniq
    end

    params[:q]["party_no_not_eq_all"] = detection_arrays[:not].flatten.uniq
  end

  # GET /next_battle_infos/1
  #def show
  #end

  # GET /next_battle_infos/new
  #def new
  #  @next_battle_info = NextBattleInfo.new
  #end

  # GET /next_battle_infos/1/edit
  #def edit
  #end

  # POST /next_battle_infos
  #def create
  #  @next_battle_info = NextBattleInfo.new(next_battle_info_params)

  #  if @next_battle_info.save
  #    redirect_to @next_battle_info, notice: "Next battle info was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /next_battle_infos/1
  #def update
  #  if @next_battle_info.update(next_battle_info_params)
  #    redirect_to @next_battle_info, notice: "Next battle info was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /next_battle_infos/1
  #def destroy
  #  @next_battle_info.destroy
  #  redirect_to next_battle_infos_url, notice: "Next battle info was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_next_battle_info
      @next_battle_info = NextBattleInfo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def next_battle_info_params
      params.require(:next_battle_info).permit(:result_no, :generate_no, :party_no, :battle_type, :enemy_party_name_id, :member_num)
    end
end
