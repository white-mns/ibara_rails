class StudiesController < ApplicationController
  include MyUtility
  before_action :set_study, only: [:show, :edit, :update, :destroy]

  # GET /studies
  def index
    resultno_set
    placeholder_set
    param_set

    @count	= Study.distinct.notnil().includes(:pc_name, :world, :party).groups(action_name, params).search(params[:q]).result.hit_count()
    @search	= Study.distinct.notnil().includes(:pc_name, :world, :party).groups(action_name, params).aggregations(action_name, params).having_order(params).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty? && params["ex_sort"] != "on"
    @studies	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "depth", params_name: "depth_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_ep", params_name: "ep_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_text", params_name: "text_form", type: "text")

    params_to_form(params, @form_params, column_name: "skill_timing_name", params_name: "timing_form", type: "text")

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

    
    pm_matching(params, @form_params)

    @form_params["group_skill"] = params["group_skill"]

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_skill")
    toggle_params_to_variable(params, @form_params, params_name: "show_skill_text")
  end
  # GET /studies/1
  #def show
  #end

  # GET /studies/new
  #def new
  #  @study = Study.new
  #end

  # GET /studies/1/edit
  #def edit
  #end

  # POST /studies
  #def create
  #  @study = Study.new(study_params)

  #  if @study.save
  #    redirect_to @study, notice: "Study was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /studies/1
  #def update
  #  if @study.update(study_params)
  #    redirect_to @study, notice: "Study was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /studies/1
  #def destroy
  #  @study.destroy
  #  redirect_to studies_url, notice: "Study was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study
      @study = Study.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def study_params
      params.require(:study).permit(:result_no, :generate_no, :e_no, :skill_id, :depth)
    end
end
