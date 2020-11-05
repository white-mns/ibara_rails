class SkillConcatenatesController < ApplicationController
  include MyUtility
  before_action :set_skill_concatenate, only: [:show, :edit, :update, :destroy]

  # GET /skill_concatenates
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = SkillConcatenate.notnil().includes(:pc_name, :world).search(params[:q]).result.hit_count()
    @search = SkillConcatenate.notnil().includes(:pc_name, :world).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @skill_concatenates = @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "skill_concatenates", params_name: "skill_concatenates_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
  end
  # GET /skill_concatenates/1
  #def show
  #end

  # GET /skill_concatenates/new
  #def new
  #  @skill_concatenate = SkillConcatenate.new
  #end

  # GET /skill_concatenates/1/edit
  #def edit
  #end

  # POST /skill_concatenates
  #def create
  #  @skill_concatenate = SkillConcatenate.new(skill_concatenate_params)

  #  if @skill_concatenate.save
  #    redirect_to @skill_concatenate, notice: "Skill concatenate was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /skill_concatenates/1
  #def update
  #  if @skill_concatenate.update(skill_concatenate_params)
  #    redirect_to @skill_concatenate, notice: "Skill concatenate was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /skill_concatenates/1
  #def destroy
  #  @skill_concatenate.destroy
  #  redirect_to skill_concatenates_url, notice: "Skill concatenate was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill_concatenate
      @skill_concatenate = SkillConcatenate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_concatenate_params
      params.require(:skill_concatenate).permit(:result_no, :generate_no, :e_no, :skill_concatenates)
    end
end
