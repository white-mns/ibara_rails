class SkillDataController < ApplicationController
  include MyUtility
  before_action :set_skill_datum, only: [:show, :edit, :update, :destroy]

  # GET /skill_data
  def index
    placeholder_set
    param_set
    @count	= SkillDatum.includes(:timing).search(params[:q]).result.count()
    @search	= SkillDatum.includes(:timing).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @skill_data	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)

    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "number")
    params_to_form(params, @form_params, column_name: "type_id", params_name: "type_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "element_id", params_name: "element_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "ep", params_name: "ep_form", type: "number")
    params_to_form(params, @form_params, column_name: "sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "timing_id", params_name: "timing_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "text", params_name: "text_form", type: "text")

    params_to_form(params, @form_params, column_name: "timing_name", params_name: "timing_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "type_id_eq_any",
                             checkboxes: [{params_name: "type_active",   value: 0, first_checked: true},
                                          {params_name: "type_passive" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "element_id_eq_any",
                             checkboxes: [{params_name: "element_none",   value: 0},
                                          {params_name: "element_fire",   value: 1},
                                          {params_name: "element_water",  value: 2},
                                          {params_name: "element_wind",   value: 3},
                                          {params_name: "element_ground", value: 4},
                                          {params_name: "element_light",  value: 5},
                                          {params_name: "element_dark",   value: 6}])
  end
  # GET /skill_data/1
  #def show
  #end

  # GET /skill_data/new
  #def new
  #  @skill_datum = SkillDatum.new
  #end

  # GET /skill_data/1/edit
  #def edit
  #end

  # POST /skill_data
  #def create
  #  @skill_datum = SkillDatum.new(skill_datum_params)

  #  if @skill_datum.save
  #    redirect_to @skill_datum, notice: "Skill datum was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /skill_data/1
  #def update
  #  if @skill_datum.update(skill_datum_params)
  #    redirect_to @skill_datum, notice: "Skill datum was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /skill_data/1
  #def destroy
  #  @skill_datum.destroy
  #  redirect_to skill_data_url, notice: "Skill datum was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill_datum
      @skill_datum = SkillDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_datum_params
      params.require(:skill_datum).permit(:skill_id, :name, :type_id, :element_id, :ep, :sp, :timing_id, :text)
    end
end
