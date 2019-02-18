class SuperpowersController < ApplicationController
  include MyUtility
  before_action :set_superpower, only: [:show, :edit, :update, :destroy]

  # GET /superpowers
  def index
    placeholder_set
    param_set
    @count	= Superpower.notnil().includes(:pc_name, :superpower).search(params[:q]).result.count()
    @search	= Superpower.notnil().includes(:pc_name, :superpower).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @superpowers	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "superpower_id", params_name: "superpower_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "lv", params_name: "lv_form", type: "number")

    params_to_form(params, @form_params, column_name: "superpower_name", params_name: "superpower_form", type: "text")
  end
  # GET /superpowers/1
  #def show
  #end

  # GET /superpowers/new
  #def new
  #  @superpower = Superpower.new
  #end

  # GET /superpowers/1/edit
  #def edit
  #end

  # POST /superpowers
  #def create
  #  @superpower = Superpower.new(superpower_params)

  #  if @superpower.save
  #    redirect_to @superpower, notice: "Superpower was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /superpowers/1
  #def update
  #  if @superpower.update(superpower_params)
  #    redirect_to @superpower, notice: "Superpower was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /superpowers/1
  #def destroy
  #  @superpower.destroy
  #  redirect_to superpowers_url, notice: "Superpower was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_superpower
      @superpower = Superpower.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def superpower_params
      params.require(:superpower).permit(:result_no, :generate_no, :e_no, :superpower_id, :lv)
    end
end
