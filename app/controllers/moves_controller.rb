class MovesController < ApplicationController
  include MyUtility
  before_action :set_move, only: [:show, :edit, :update, :destroy]

  # GET /moves
  def index
    resultno_set
    placeholder_set
    param_set

    @count	= Move.notnil().includes(:pc_name, :world, :field, :party).search(params[:q]).result.count()
    @search	= Move.notnil().includes(:pc_name, :world, :field, :party).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @moves	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "move_no", params_name: "move_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "field_id", params_name: "field_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "area", params_name: "area_form", type: "number")
    params_to_form(params, @form_params, column_name: "area_column", params_name: "area_column_form", type: "number")
    params_to_form(params, @form_params, column_name: "area_row", params_name: "area_row_form", type: "number")
    params_to_form(params, @form_params, column_name: "landform_id", params_name: "landform_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "field_name", params_name: "field_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "landform_id_eq_any",
                             checkboxes: [{params_name: "landform_1", value: 1},
                                          {params_name: "landform_2", value: 2},
                                          {params_name: "landform_3", value: 3},
                                          {params_name: "landform_4", value: 4},
                                          {params_name: "landform_5", value: 5}])

    pm_matching(params, @form_params)

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
  end
  # GET /moves/1
  #def show
  #end

  # GET /moves/new
  #def new
  #  @move = Move.new
  #end

  # GET /moves/1/edit
  #def edit
  #end

  # POST /moves
  #def create
  #  @move = Move.new(move_params)

  #  if @move.save
  #    redirect_to @move, notice: "Move was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /moves/1
  #def update
  #  if @move.update(move_params)
  #    redirect_to @move, notice: "Move was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /moves/1
  #def destroy
  #  @move.destroy
  #  redirect_to moves_url, notice: "Move was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_move
      @move = Move.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def move_params
      params.require(:move).permit(:result_no, :generate_no, :e_no, :move_no, :field_id, :area, :area_column, :area_row, :landform_id)
    end
end
