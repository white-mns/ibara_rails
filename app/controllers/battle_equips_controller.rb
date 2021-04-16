class BattleEquipsController < ApplicationController
  include MyUtility
  before_action :set_battle_equip, only: [:show, :edit, :update, :destroy]

  # GET /battle_equips
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = BattleEquip.notnil().includes(:battle_info, :pc_name, :world, :party).search(params[:q]).result.hit_count()
    @search = BattleEquip.notnil().includes(:battle_info, :pc_name, :world, :party).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @battle_equips = @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_id", params_name: "battle_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "equip_no", params_name: "equip_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "kind_id", params_name: "kind_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "strength", params_name: "strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "range", params_name: "range_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_1_id", params_name: "effect_1_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_1_value", params_name: "effect_1_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_2_id", params_name: "effect_2_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_2_value", params_name: "effect_2_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_3_id", params_name: "effect_3_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_3_value", params_name: "effect_3_value_form", type: "number")

    params_to_form(params, @form_params, column_name: "kind_name", params_name: "kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "effect_1_name_or_effect_2_name_or_effect_3_name", params_name: "effect_form", type: "text")
    params_to_form(params, @form_params, column_name: "effect_1_name", params_name: "effect_1_form", type: "text")
    params_to_form(params, @form_params, column_name: "effect_2_name", params_name: "effect_2_form", type: "text")
    params_to_form(params, @form_params, column_name: "effect_3_name", params_name: "effect_3_form", type: "text")

    params_to_form(params, @form_params, column_name: "place_area_column", params_name: "area_column_form", type: "text")
    params_to_form(params, @form_params, column_name: "place_area_row", params_name: "area_row_form", type: "number")
    params_to_form(params, @form_params, column_name: "place_field_name", params_name: "field_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_info_battle_type_eq_any",
                             checkboxes: [{params_name: "is_encounter",  value: 0,  first_checked: false},
                                          {params_name: "is_mission",    value: 1,  first_checked: false},
                                          {params_name: "is_duel",       value: 10, first_checked: false},
                                          {params_name: "is_game",       value: 11, first_checked: false},
                                          {params_name: "is_tournament", value: 20, first_checked: false}])

    pm_matching(params, @form_params)

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
    toggle_params_to_variable(params, @form_params, params_name: "show_fuka")
  end
  # GET /battle_equips/1
  #def show
  #end

  # GET /battle_equips/new
  #def new
  #  @battle_equip = BattleEquip.new
  #end

  # GET /battle_equips/1/edit
  #def edit
  #end

  # POST /battle_equips
  #def create
  #  @battle_equip = BattleEquip.new(battle_equip_params)

  #  if @battle_equip.save
  #    redirect_to @battle_equip, notice: "Battle equip was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /battle_equips/1
  #def update
  #  if @battle_equip.update(battle_equip_params)
  #    redirect_to @battle_equip, notice: "Battle equip was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /battle_equips/1
  #def destroy
  #  @battle_equip.destroy
  #  redirect_to battle_equips_url, notice: "Battle equip was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_equip
      @battle_equip = BattleEquip.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_equip_params
      params.require(:battle_equip).permit(:result_no, :generate_no, :e_no, :battle_id, :equip_no, :name, :kind_id, :strength, :range, :effect_1_id, :effect_1_value, :effect_2_id, :effect_2_value, :effect_3_id, :effect_3_value)
    end
end
