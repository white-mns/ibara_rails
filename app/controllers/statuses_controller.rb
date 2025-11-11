class StatusesController < ApplicationController
  include MyUtility
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  def index
    placeholder_set
    param_set
    @count	= Status.notnil().includes(:pc_name, :world, :place, :party).ransack(params[:q]).result.count()
    @search	= Status.notnil().includes(:pc_name, :world, :place, :party).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @statuses	= @search.result.per(50)
  end

  # GET /styles
  def style
      index
  end

  # GET /effects
  def effect
      index
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
    params_to_form(params, @form_params, column_name: "style_id", params_name: "style_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect", params_name: "effect_form", type: "number")
    params_to_form(params, @form_params, column_name: "mhp", params_name: "mhp_form", type: "number")
    params_to_form(params, @form_params, column_name: "msp", params_name: "msp_form", type: "number")
    params_to_form(params, @form_params, column_name: "landform_id", params_name: "landform_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "condition", params_name: "condition_form", type: "number")
    params_to_form(params, @form_params, column_name: "max_condition", params_name: "max_condition_form", type: "number")
    params_to_form(params, @form_params, column_name: "ps", params_name: "ps_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    params_to_form(params, @form_params, column_name: "place_area_column", params_name: "area_column_form", type: "text")
    params_to_form(params, @form_params, column_name: "place_area_row", params_name: "area_row_form", type: "number")
    params_to_form(params, @form_params, column_name: "place_field_name", params_name: "field_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "style_id_eq_any",
                             checkboxes: [{params_name: "style_1", value: 1},
                                          {params_name: "style_2", value: 2},
                                          {params_name: "style_3", value: 3},
                                          {params_name: "style_4", value: 4},
                                          {params_name: "style_5", value: 5},
                                          {params_name: "style_6", value: 6},
                                          {params_name: "style_7", value: 7},
                                          {params_name: "style_8", value: 8},
                                          {params_name: "style_9", value: 9}])

    checkbox_params_set_query_any(params, @form_params, query_name: "landform_id_eq_any",
                             checkboxes: [{params_name: "landform_1", value: 1},
                                          {params_name: "landform_2", value: 2},
                                          {params_name: "landform_3", value: 3},
                                          {params_name: "landform_4", value: 4},
                                          {params_name: "landform_5", value: 5}])

    girth_matching(params, @form_params)
    pm_matching(params, @form_params)
   
    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
  end
  # GET /statuses/1
  #def show
  #end

  # GET /statuses/new
  #def new
  #  @status = Status.new
  #end

  # GET /statuses/1/edit
  #def edit
  #end

  # POST /statuses
  #def create
  #  @status = Status.new(status_params)

  #  if @status.save
  #    redirect_to @status, notice: "Status was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /statuses/1
  #def update
  #  if @status.update(status_params)
  #    redirect_to @status, notice: "Status was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /statuses/1
  #def destroy
  #  @status.destroy
  #  redirect_to statuses_url, notice: "Status was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def status_params
      params.require(:status).permit(:result_no, :generate_no, :e_no, :style_id, :effect, :mhp, :msp, :landform_id, :condition, :max_condition, :ps)
    end
end
