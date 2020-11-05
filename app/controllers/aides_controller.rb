class AidesController < ApplicationController
  include MyUtility
  before_action :set_aide, only: [:show, :edit, :update, :destroy]

  # GET /aides
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = Aide.notnil().includes(:pc_name, :world, :enemy, :employ).search(params[:q]).result.hit_count()
    @search = Aide.notnil().includes(:pc_name, :world, :enemy, :employ).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @aides  = @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "aide_no", params_name: "aide_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "enemy_id", params_name: "enemy_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "cost_sp", params_name: "cost_sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "bonds", params_name: "bonds_form", type: "number")
    params_to_form(params, @form_params, column_name: "mhp", params_name: "mhp_form", type: "number")
    params_to_form(params, @form_params, column_name: "msp", params_name: "msp_form", type: "number")
    params_to_form(params, @form_params, column_name: "mep", params_name: "mep_form", type: "number")
    params_to_form(params, @form_params, column_name: "range", params_name: "range_form", type: "number")
    params_to_form(params, @form_params, column_name: "fuka_texts", params_name: "fuka_texts_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_texts", params_name: "skill_texts_form", type: "text")
    
    params_to_form(params, @form_params, column_name: "employ_lv", params_name: "employ_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_name", params_name: "enemy_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_employ")
    toggle_params_to_variable(params, @form_params, params_name: "show_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_status")
    toggle_params_to_variable(params, @form_params, params_name: "show_fuka")
    toggle_params_to_variable(params, @form_params, params_name: "show_skill")
  end
  # GET /aides/1
  #def show
  #end

  # GET /aides/new
  #def new
  #  @aide = Aide.new
  #end

  # GET /aides/1/edit
  #def edit
  #end

  # POST /aides
  #def create
  #  @aide = Aide.new(aide_params)

  #  if @aide.save
  #    redirect_to @aide, notice: "Aide was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /aides/1
  #def update
  #  if @aide.update(aide_params)
  #    redirect_to @aide, notice: "Aide was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /aides/1
  #def destroy
  #  @aide.destroy
  #  redirect_to aides_url, notice: "Aide was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aide
      @aide = Aide.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def aide_params
      params.require(:aide).permit(:result_no, :generate_no, :e_no, :aide_no, :name, :enemy_id, :cost_sp, :bonds, :mhp, :msp, :mep, :range, :fuka_texts, :skill_texts)
    end
end
