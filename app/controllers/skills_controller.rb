class SkillsController < ApplicationController
  include MyUtility
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  # GET /skills
  def index
    placeholder_set
    param_set
    @count	= Skill.distinct.notnil().includes(:pc_name, :world, [skill: :timing], [skill_mastery: [:requirement_1, :requirement_2]], :place, :party, :status).groups(params).search(params[:q]).result.hit_count()
    @search	= Skill.distinct.notnil().includes(:pc_name, :world, [skill: :timing], [skill_mastery: [:requirement_1, :requirement_2]], :place, :party, :status).groups(params).total(params).having_order(params).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty? && params["ex_sort"] != "on"
    @skills	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "lv", params_name: "lv_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_ep", params_name: "ep_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_text", params_name: "text_form", type: "text")

    params_to_form(params, @form_params, column_name: "skill_timing_name", params_name: "timing_form", type: "text")

    params_to_form(params, @form_params, column_name: "skill_mastery_requirement_1_name_or_skill_mastery_requirement_2_name", params_name: "requirement_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_mastery_requirement_1_lv_or_requirement_2_lv", params_name: "requirement_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_mastery_requirement_1_name", params_name: "requirement_1_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_mastery_requirement_1_lv", params_name: "requirement_1_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_mastery_requirement_2_name", params_name: "requirement_2_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_mastery_requirement_2_lv", params_name: "requirement_2_lv_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "skill_type_id_eq_any",
                             checkboxes: [{params_name: "type_active",   value: 0, first_checked: true},
                                          {params_name: "type_passive" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "skill_element_id_eq_any",
                             checkboxes: [{params_name: "element_none",   value: 0},
                                          {params_name: "element_fire",   value: 1},
                                          {params_name: "element_water",  value: 2},
                                          {params_name: "element_wind",   value: 3},
                                          {params_name: "element_ground", value: 4},
                                          {params_name: "element_light",  value: 5},
                                          {params_name: "element_dark",   value: 6}])
    
    checkbox_params_set_query_any(params, @form_params, query_name: "status_style_id_eq_any",
                             checkboxes: [{params_name: "style_1", value: 1},
                                          {params_name: "style_2", value: 2},
                                          {params_name: "style_3", value: 3},
                                          {params_name: "style_4", value: 4},
                                          {params_name: "style_5", value: 5},
                                          {params_name: "style_6", value: 6},
                                          {params_name: "style_7", value: 7},
                                          {params_name: "style_8", value: 8},
                                          {params_name: "style_9", value: 9}])

    girth_matching(params, @form_params)
    pm_matching(params, @form_params)
    initial_skill_matching(params, @form_params)

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_skill")
    toggle_params_to_variable(params, @form_params, params_name: "show_skill_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_skill_text")
    toggle_params_to_variable(params, @form_params, params_name: "show_skill_mastery")
    toggle_params_to_variable(params, @form_params, params_name: "show_style")
    toggle_params_to_variable(params, @form_params, params_name: "show_total")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
  end

  def initial_skill_matching(params, form_params)
      params_tmp = {}
      params_tmp[:q] = {}
      if params["exclude_initial_active"] && params["exclude_initial_passive"]
          params_tmp["ex_name_form"] = "ブレイク/ピンポイント/ヒール/クイック/ブラスト/攻撃/防御/器用/敏捷/回復/活力/体力/治癒/鎮痛/幸運"
      elsif params["exclude_initial_active"]
          params_tmp["ex_name_form"] = "ブレイク/ピンポイント/ヒール/クイック/ブラスト"
      elsif params["exclude_initial_passive"]
          params_tmp["ex_name_form"] = "攻撃/防御/器用/敏捷/回復/活力/体力/治癒/鎮痛/幸運"
      end
    
      params_to_form(params_tmp, form_params, column_name: "name", params_name: "ex_name_form", type: "number")

      if params["exclude_initial_active"] || params["exclude_initial_passive"]
          exclude_array = SkillDatum.search(params_tmp[:q]).result.pluck(:skill_id)
          params[:q]["skill_id_not_eq_all"] = exclude_array
          
      end

      form_params["exclude_initial_active"] = params["exclude_initial_active"]
      form_params["exclude_initial_passive"] = params["exclude_initial_passive"]
  end



  # GET /skills/1
  #def show
  #end

  # GET /skills/new
  #def new
  #  @skill = Skill.new
  #end

  # GET /skills/1/edit
  #def edit
  #end

  # POST /skills
  #def create
  #  @skill = Skill.new(skill_params)

  #  if @skill.save
  #    redirect_to @skill, notice: "Skill was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /skills/1
  #def update
  #  if @skill.update(skill_params)
  #    redirect_to @skill, notice: "Skill was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /skills/1
  #def destroy
  #  @skill.destroy
  #  redirect_to skills_url, notice: "Skill was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_params
      params.require(:skill).permit(:result_no, :generate_no, :e_no, :name, :skill_id, :lv)
    end
end
