class NewItemFukasController < ApplicationController
  include MyUtility
  before_action :set_new_item_fuka, only: [:show, :edit, :update, :destroy]

  # GET /new_item_fukas
  def index
    resultno_set
    placeholder_set
    param_set

    @count	= NewItemFuka.notnil().includes(:fuka).search(params[:q]).result.hit_count()
    @search	= NewItemFuka.notnil().includes(:fuka).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @new_item_fukas	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "fuka_id", params_name: "fuka_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "fuka_name", params_name: "fuka_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
  end
  # GET /new_item_fukas/1
  #def show
  #end

  # GET /new_item_fukas/new
  #def new
  #  @new_item_fuka = NewItemFuka.new
  #end

  # GET /new_item_fukas/1/edit
  #def edit
  #end

  # POST /new_item_fukas
  #def create
  #  @new_item_fuka = NewItemFuka.new(new_item_fuka_params)

  #  if @new_item_fuka.save
  #    redirect_to @new_item_fuka, notice: "New item fuka was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_item_fukas/1
  #def update
  #  if @new_item_fuka.update(new_item_fuka_params)
  #    redirect_to @new_item_fuka, notice: "New item fuka was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_item_fukas/1
  #def destroy
  #  @new_item_fuka.destroy
  #  redirect_to new_item_fukas_url, notice: "New item fuka was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_item_fuka
      @new_item_fuka = NewItemFuka.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_item_fuka_params
      params.require(:new_item_fuka).permit(:result_no, :generate_no, :fuka_id)
    end
end
