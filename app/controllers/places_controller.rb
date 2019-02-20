class PlacesController < ApplicationController
  include MyUtility
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  def index
    placeholder_set
    param_set
    @count	= Place.notnil().includes(:pc_name, :world, :field).search(params[:q]).result.count()
    @search	= Place.notnil().includes(:pc_name, :world, :field).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @places	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    if params["area_column_form"] then
        params["area_column_form"].upcase!
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "field_id", params_name: "field_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "area_column", params_name: "area_column_form", type: "text")
    params_to_form(params, @form_params, column_name: "area_row", params_name: "area_row_form", type: "number")
    
    params_to_form(params, @form_params, column_name: "field_name", params_name: "field_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])


    # キャラ周囲絞り込み用
    params2 = {}
    params2[:q] = {}
    params2["place_e_no_form"] = params["place_e_no_form"]
    params2["place_pc_name_form"] = params["place_pc_name_form"]

    params_to_form(params2, @form_params, column_name: "e_no", params_name: "place_e_no_form", type: "number")
    params_to_form(params2, @form_params, column_name: "pc_name_name", params_name: "place_pc_name_form", type: "text")

    if params["place_e_no_form"] || params["place_pc_name_form"]
        place_array = Place.pc_to_place_array(params2)
        params[:q]["area_cont_any"] = place_array
    end
    
    @form_params["place_e_no_form"] = params["place_e_no_form"]
    @form_params["place_pc_name_form"] = params["place_pc_name_form"]

    # toggle操作用
    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_girth")
  end
  # GET /places/1
  #def show
  #end

  # GET /places/new
  #def new
  #  @place = Place.new
  #end

  # GET /places/1/edit
  #def edit
  #end

  # POST /places
  #def create
  #  @place = Place.new(place_params)

  #  if @place.save
  #    redirect_to @place, notice: "Place was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /places/1
  #def update
  #  if @place.update(place_params)
  #    redirect_to @place, notice: "Place was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /places/1
  #def destroy
  #  @place.destroy
  #  redirect_to places_url, notice: "Place was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def place_params
      params.require(:place).permit(:result_no, :generate_no, :e_no, :field_id, :area, :area_column, :area_row)
    end
end
