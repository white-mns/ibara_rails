class MovePartyCountsController < ApplicationController
  include MyUtility
  before_action :set_move_party_count, only: [:show, :edit, :update, :destroy]

  # GET /move_party_counts
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = MovePartyCount.notnil().includes(:world).search(params[:q]).result.count()
    @search = MovePartyCount.notnil().includes(:world).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @move_party_counts = @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
      params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_no", params_name: "party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "landform_id", params_name: "landform_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "move_count", params_name: "move_count_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "landform_id_eq_any",
                             checkboxes: [{params_name: "landform_1", value: 1},
                                          {params_name: "landform_2", value: 2},
                                          {params_name: "landform_3", value: 3},
                                          {params_name: "landform_4", value: 4},
                                          {params_name: "landform_5", value: 5}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
  end
  # GET /move_party_counts/1
  #def show
  #end

  # GET /move_party_counts/new
  #def new
  #  @move_party_count = MovePartyCount.new
  #end

  # GET /move_party_counts/1/edit
  #def edit
  #end

  # POST /move_party_counts
  #def create
  #  @move_party_count = MovePartyCount.new(move_party_count_params)

  #  if @move_party_count.save
  #    redirect_to @move_party_count, notice: "Move party count was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /move_party_counts/1
  #def update
  #  if @move_party_count.update(move_party_count_params)
  #    redirect_to @move_party_count, notice: "Move party count was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /move_party_counts/1
  #def destroy
  #  @move_party_count.destroy
  #  redirect_to move_party_counts_url, notice: "Move party count was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_move_party_count
      @move_party_count = MovePartyCount.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def move_party_count_params
      params.require(:move_party_count).permit(:result_no, :generate_no, :party_no, :landform_id, :move_count)
    end
end
