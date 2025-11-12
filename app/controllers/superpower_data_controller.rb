class SuperpowerDataController < ApplicationController
  include MyUtility
  before_action :set_superpower_datum, only: [:show, :edit, :update, :destroy]

  # GET /superpower_data
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = SuperpowerDatum.ransack(params[:q]).result.count()
    @search = SuperpowerDatum.page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @superpower_data = @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
      params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "superpower_id", params_name: "superpower_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "text", params_name: "text_form", type: "text")
  end
  # GET /superpower_data/1
  #def show
  #end

  # GET /superpower_data/new
  #def new
  #  @superpower_datum = SuperpowerDatum.new
  #end

  # GET /superpower_data/1/edit
  #def edit
  #end

  # POST /superpower_data
  #def create
  #  @superpower_datum = SuperpowerDatum.new(superpower_datum_params)

  #  if @superpower_datum.save
  #    redirect_to @superpower_datum, notice: "Superpower datum was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /superpower_data/1
  #def update
  #  if @superpower_datum.update(superpower_datum_params)
  #    redirect_to @superpower_datum, notice: "Superpower datum was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /superpower_data/1
  #def destroy
  #  @superpower_datum.destroy
  #  redirect_to superpower_data_url, notice: "Superpower datum was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_superpower_datum
      @superpower_datum = SuperpowerDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def superpower_datum_params
      params.require(:superpower_datum).permit(:superpower_id, :name, :text)
    end
end
