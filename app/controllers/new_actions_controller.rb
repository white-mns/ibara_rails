class NewActionsController < ApplicationController
  include MyUtility
  before_action :set_new_action, only: [:show, :edit, :update, :destroy]

  # GET /new_actions
  def index
    resultno_set
    placeholder_set
    skill_data_set
    param_set

    @count  = NewAction.notnil().includes(:skill, :fuka).search(params[:q]).result.hit_count()
    @search = NewAction.notnil().includes(:skill, :fuka).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @new_actions = @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "fuka_id", params_name: "fuka_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "skill_name_or_fuka_name", params_name: "act_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
  end
  # GET /new_actions/1
  #def show
  #end

  # GET /new_actions/new
  #def new
  #  @new_action = NewAction.new
  #end

  # GET /new_actions/1/edit
  #def edit
  #end

  # POST /new_actions
  #def create
  #  @new_action = NewAction.new(new_action_params)

  #  if @new_action.save
  #    redirect_to @new_action, notice: "New action was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_actions/1
  #def update
  #  if @new_action.update(new_action_params)
  #    redirect_to @new_action, notice: "New action was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_actions/1
  #def destroy
  #  @new_action.destroy
  #  redirect_to new_actions_url, notice: "New action was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_action
      @new_action = NewAction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_action_params
      params.require(:new_action).permit(:result_no, :generate_no, :skill_id, :fuka_id)
    end
end
