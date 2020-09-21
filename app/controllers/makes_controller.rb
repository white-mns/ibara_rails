class MakesController < ApplicationController
  include MyUtility
  before_action :set_make, only: [:show, :edit, :update, :destroy]

  # GET /makes
  def index
    resultno_set
    placeholder_set
    param_set

    @count	= Make.notnil().includes(:pc_name, :world, :last_item, :item, :kind).search(params[:q]).result.hit_count()
    @search	= Make.notnil().includes(:pc_name, :world, :last_item, :item, :kind).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @makes	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "last_result_no", params_name: "last_result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "last_generate_no", params_name: "last_generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "i_no", params_name: "i_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "kind_id", params_name: "kind_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "strength", params_name: "strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "source_name", params_name: "source_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "kind_name", params_name: "kind_form", type: "text")
    params_to_form(params, @form_params, column_name: "last_item_strength", params_name: "source_strength_form", type: "number")

    params_to_form(params, @form_params, column_name: "item_effect_1_name_or_item_effect_2_name_or_item_effect_3_name", params_name: "effect_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_1_value", params_name: "effect_1_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_1_name", params_name: "effect_1_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_2_value", params_name: "effect_2_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_2_name", params_name: "effect_2_form", type: "text")
    params_to_form(params, @form_params, column_name: "item_effect_3_value", params_name: "effect_3_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "item_effect_3_name", params_name: "effect_3_form", type: "text")


    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_name", first_opened: true)
    toggle_params_to_variable(params, @form_params, params_name: "show_source", first_opened: true)
    toggle_params_to_variable(params, @form_params, params_name: "show_fuka")
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /makes/1
  #def show
  #end

  # GET /makes/new
  #def new
  #  @make = Make.new
  #end

  # GET /makes/1/edit
  #def edit
  #end

  # POST /makes
  #def create
  #  @make = Make.new(make_params)

  #  if @make.save
  #    redirect_to @make, notice: "Make was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /makes/1
  #def update
  #  if @make.update(make_params)
  #    redirect_to @make, notice: "Make was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /makes/1
  #def destroy
  #  @make.destroy
  #  redirect_to makes_url, notice: "Make was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_make
      @make = Make.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def make_params
      params.require(:make).permit(:result_no, :generate_no, :e_no, :last_result_no, :last_generate_no, :i_no, :name, :kind_id, :strength)
    end
end
