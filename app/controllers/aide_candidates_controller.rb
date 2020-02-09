class AideCandidatesController < ApplicationController
  include MyUtility
  before_action :set_aide_candidate, only: [:show, :edit, :update, :destroy]

  # GET /aide_candidates
  def index
    placeholder_set
    param_set
    @count	= AideCandidate.notnil().includes(:pc_name, :world, :enemy, :employ, :last_employ).search(params[:q]).result.hit_count()
    @search	= AideCandidate.notnil().includes(:pc_name, :world, :enemy, :employ, :last_employ).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @aide_candidates	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "enemy_id", params_name: "enemy_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "employ_lv", params_name: "employ_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "last_employ_lv", params_name: "employ_lv_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_name", params_name: "enemy_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_employ")
    toggle_params_to_variable(params, @form_params, params_name: "show_last_employ")
  end
  # GET /aide_candidates/1
  #def show
  #end

  # GET /aide_candidates/new
  #def new
  #  @aide_candidate = AideCandidate.new
  #end

  # GET /aide_candidates/1/edit
  #def edit
  #end

  # POST /aide_candidates
  #def create
  #  @aide_candidate = AideCandidate.new(aide_candidate_params)

  #  if @aide_candidate.save
  #    redirect_to @aide_candidate, notice: "Aide candidate was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /aide_candidates/1
  #def update
  #  if @aide_candidate.update(aide_candidate_params)
  #    redirect_to @aide_candidate, notice: "Aide candidate was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /aide_candidates/1
  #def destroy
  #  @aide_candidate.destroy
  #  redirect_to aide_candidates_url, notice: "Aide candidate was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aide_candidate
      @aide_candidate = AideCandidate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def aide_candidate_params
      params.require(:aide_candidate).permit(:result_no, :generate_no, :e_no, :enemy_id)
    end
end
