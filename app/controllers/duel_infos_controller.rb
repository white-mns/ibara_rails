class DuelInfosController < ApplicationController
  include MyUtility
  before_action :set_duel_info, only: [:show, :edit, :update, :destroy]

  # GET /duel_infos
  def index
    resultno_set
    placeholder_set
    param_set

    @count	= DuelInfo.distinct.notnil().includes(:battle_info, :battle_result, :left_world, :right_world, [left_party_info: [party_members: :pc_name]], [right_party_info: [party_members: :pc_name]]).search(params[:q]).result.hit_count()
    @search	= DuelInfo.distinct.notnil().includes(:battle_info, :battle_result, :left_world, :right_world, [left_party_info: [party_members: :pc_name]], [right_party_info: [party_members: :pc_name]]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @duel_infos	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "left_party_no", params_name: "left_party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "right_party_no", params_name: "right_party_no_form", type: "number")

    params_to_form(params, @form_params, column_name: "left_party_info_member_num", params_name: "left_member_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "right_party_info_member_num", params_name: "right_member_num_form", type: "number")

    params_to_form(params, @form_params, column_name: "left_party_info_party_members_e_no", params_name: "left_e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "left_party_info_party_members_pc_name_name", params_name: "left_pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "right_party_info_party_members_e_no", params_name: "right_e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "right_party_info_party_members_pc_name_name", params_name: "right_pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "left_party_info_party_members_e_no_or_right_party_info_party_members_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "left_party_info_party_members_pc_name_name_or_right_party_info_party_members_pc_name_name", params_name: "pc_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "left_party_info_name", params_name: "left_party_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "right_party_info_name", params_name: "right_party_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "left_party_info_name_or_right_party_info_name", params_name: "party_name_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "left_party_info_member_num_eq_any",
                             checkboxes: [{params_name: "left_member_num_1", value: 1, first_checked: false},
                                          {params_name: "left_member_num_2", value: 2, first_checked: false},
                                          {params_name: "left_member_num_3", value: 3, first_checked: false},
                                          {params_name: "left_member_num_4", value: 4, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "right_party_info_member_num_eq_any",
                             checkboxes: [{params_name: "right_member_num_1", value: 1, first_checked: false},
                                          {params_name: "right_member_num_2", value: 2, first_checked: false},
                                          {params_name: "right_member_num_3", value: 3, first_checked: false},
                                          {params_name: "right_member_num_4", value: 4, first_checked: false}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_info_battle_type_eq_any",
                             checkboxes: [{params_name: "is_duel", value: 10, first_checked: true},
                                          {params_name: "is_game" ,  value: 11, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_result_battle_result_eq_any",
                             checkboxes: [{params_name: "result_win",   value: 1, first_checked: true},
                                          {params_name: "result_draw",  value: 0, first_checked: true},
                                          {params_name: "result_lose" , value: -1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "left_world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_member_num")
    toggle_params_to_variable(params, @form_params, params_name: "show_party_name")
  end
  # GET /duel_infos/1
  #def show
  #end

  # GET /duel_infos/new
  #def new
  #  @duel_info = DuelInfo.new
  #end

  # GET /duel_infos/1/edit
  #def edit
  #end

  # POST /duel_infos
  #def create
  #  @duel_info = DuelInfo.new(duel_info_params)

  #  if @duel_info.save
  #    redirect_to @duel_info, notice: "Duel info was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /duel_infos/1
  #def update
  #  if @duel_info.update(duel_info_params)
  #    redirect_to @duel_info, notice: "Duel info was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /duel_infos/1
  #def destroy
  #  @duel_info.destroy
  #  redirect_to duel_infos_url, notice: "Duel info was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_duel_info
      @duel_info = DuelInfo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def duel_info_params
      params.require(:duel_info).permit(:result_no, :generate_no, :battle_id, :left_party_no, :right_party_no)
    end
end
