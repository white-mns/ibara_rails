class SkillMasteriesController < ApplicationController
  include MyUtility
  before_action :set_skill_mastery, only: [:show, :edit, :update, :destroy]

  # GET /skill_masteries
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = SkillMastery.includes(:requirement_1, :requirement_2, :skill).ransack(params[:q]).result.count()
    @search = SkillMastery.includes(:requirement_1, :requirement_2, :skill).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @skill_masteries = @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
      params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "requirement_1_id", params_name: "requirement_1_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "requirement_1_lv", params_name: "requirement_1_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "requirement_2_id", params_name: "requirement_2_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "requirement_2_lv", params_name: "requirement_2_lv_form", type: "number")

    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")

    params_to_form(params, @form_params, column_name: "requirement_1_name_or_requirement_2_name", params_name: "requirement_form", type: "text")
    params_to_form(params, @form_params, column_name: "requirement_1_lv_or_requirement_2_lv", params_name: "requirement_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "requirement_1_name", params_name: "requirement_1_form", type: "text")
    params_to_form(params, @form_params, column_name: "requirement_2_name", params_name: "requirement_2_form", type: "text")
  end
  # GET /skill_masteries/1
  #def show
  #end

  # GET /skill_masteries/new
  #def new
  #  @skill_mastery = SkillMastery.new
  #end

  # GET /skill_masteries/1/edit
  #def edit
  #end

  # POST /skill_masteries
  #def create
  #  @skill_mastery = SkillMastery.new(skill_mastery_params)

  #  if @skill_mastery.save
  #    redirect_to @skill_mastery, notice: "Skill mastery was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /skill_masteries/1
  #def update
  #  if @skill_mastery.update(skill_mastery_params)
  #    redirect_to @skill_mastery, notice: "Skill mastery was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /skill_masteries/1
  #def destroy
  #  @skill_mastery.destroy
  #  redirect_to skill_masteries_url, notice: "Skill mastery was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill_mastery
      @skill_mastery = SkillMastery.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_mastery_params
      params.require(:skill_mastery).permit(:skill_id, :requirement_1_id, :requirement_1_lv, :requirement_2_id, :requirement_2_lv)
    end
end
