class MealsController < ApplicationController
  include MyUtility
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  # GET /meals
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = Meal.notnil().includes(:pc_name, :world, :last_item, :effect_1, :effect_2, :effect_3, :party).ransack(params[:q]).result.hit_count()
    @search = Meal.notnil().includes(:pc_name, :world, :last_item, :effect_1, :effect_2, :effect_3, :party).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @meals  = @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "last_result_no", params_name: "last_result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "last_generate_no", params_name: "last_generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "i_no", params_name: "i_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "recovery", params_name: "recovery_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_1_id", params_name: "effect_1_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_1_value", params_name: "effect_1_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_2_id", params_name: "effect_2_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_2_value", params_name: "effect_2_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_3_id", params_name: "effect_3_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "effect_3_value", params_name: "effect_3_value_form", type: "number")
    
    params_to_form(params, @form_params, column_name: "effect_1_name_or_effect_2_name_or_effect_3_name", params_name: "effect_form", type: "text")
    params_to_form(params, @form_params, column_name: "effect_1_name", params_name: "effect_1_form", type: "text")
    params_to_form(params, @form_params, column_name: "effect_2_name", params_name: "effect_2_form", type: "text")
    params_to_form(params, @form_params, column_name: "effect_3_name", params_name: "effect_3_form", type: "text")
    params_to_form(params, @form_params, column_name: "last_item_strength", params_name: "strength_form", type: "number")
    params_to_form(params, @form_params, column_name: "last_item_kind_name", params_name: "kind_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_fuka")
    toggle_params_to_variable(params, @form_params, params_name: "show_name")
  end
  # GET /meals/1
  #def show
  #end

  # GET /meals/new
  #def new
  #  @meal = Meal.new
  #end

  # GET /meals/1/edit
  #def edit
  #end

  # POST /meals
  #def create
  #  @meal = Meal.new(meal_params)

  #  if @meal.save
  #    redirect_to @meal, notice: "Meal was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /meals/1
  #def update
  #  if @meal.update(meal_params)
  #    redirect_to @meal, notice: "Meal was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /meals/1
  #def destroy
  #  @meal.destroy
  #  redirect_to meals_url, notice: "Meal was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def meal_params
      params.require(:meal).permit(:result_no, :generate_no, :e_no, :last_result_no, :last_generate_no, :i_no, :name, :recovery, :effect_1_id, :effect_1_value, :effect_2_id, :effect_2_value, :effect_3_id, :effect_3_value)
    end
end
