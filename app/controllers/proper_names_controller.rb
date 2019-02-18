class ProperNamesController < ApplicationController
  include MyUtility
  before_action :set_proper_name, only: [:show, :edit, :update, :destroy]

  # GET /proper_names
  def index
    placeholder_set
    param_set
    @count	= ProperName.search(params[:q]).result.count()
    @search	= ProperName.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @proper_names	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)

    params_to_form(params, @form_params, column_name: "proper_id", params_name: "proper_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
  end
  # GET /proper_names/1
  #def show
  #end

  # GET /proper_names/new
  #def new
  #  @proper_name = ProperName.new
  #end

  # GET /proper_names/1/edit
  #def edit
  #end

  # POST /proper_names
  #def create
  #  @proper_name = ProperName.new(proper_name_params)

  #  if @proper_name.save
  #    redirect_to @proper_name, notice: "Proper name was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /proper_names/1
  #def update
  #  if @proper_name.update(proper_name_params)
  #    redirect_to @proper_name, notice: "Proper name was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /proper_names/1
  #def destroy
  #  @proper_name.destroy
  #  redirect_to proper_names_url, notice: "Proper name was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proper_name
      @proper_name = ProperName.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def proper_name_params
      params.require(:proper_name).permit(:proper_id, :name)
    end
end
