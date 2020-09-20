class AdditionsController < ApplicationController
  include MyUtility
  before_action :set_addition, only: [:show, :edit, :update, :destroy]

  # GET /additions
  def index
    resultno_set
    placeholder_set
    param_set

    @count	= Addition.notnil().includes(:pc_name, :world, :requester, :party, [item: [:effect_1, :effect_2, :effect_3]]).search(params[:q]).result.hit_count()
    @search	= Addition.notnil().includes(:pc_name, :world, :requester, :party, [item: [:effect_1, :effect_2, :effect_3]]).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @additions	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "requester_name", params_name: "requester_pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "requester_e_no", params_name: "requester_e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "addition_id", params_name: "addition_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "last_result_no", params_name: "last_result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "last_generate_no", params_name: "last_generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "target_i_no", params_name: "target_i_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "target_name", params_name: "target_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "addition_i_no", params_name: "addition_i_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "addition_name", params_name: "addition_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "item_effect_2_value", params_name: "effect_2_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_2_name", params_name: "effect_2_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_target_name")
  end
  # GET /additions/1
  #def show
  #end

  # GET /additions/new
  #def new
  #  @addition = Addition.new
  #end

  # GET /additions/1/edit
  #def edit
  #end

  # POST /additions
  #def create
  #  @addition = Addition.new(addition_params)

  #  if @addition.save
  #    redirect_to @addition, notice: "Addition was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /additions/1
  #def update
  #  if @addition.update(addition_params)
  #    redirect_to @addition, notice: "Addition was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /additions/1
  #def destroy
  #  @addition.destroy
  #  redirect_to additions_url, notice: "Addition was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_addition
      @addition = Addition.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def addition_params
      params.require(:addition).permit(:result_no, :generate_no, :e_no, :requester_e_no, :addition_id, :last_result_no, :last_generate_no, :target_i_no, :target_name, :addition_i_no, :addition_name)
    end
end
