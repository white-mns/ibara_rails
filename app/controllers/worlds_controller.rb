class WorldsController < ApplicationController
  include MyUtility
  before_action :set_world, only: [:show, :edit, :update, :destroy]

  # GET /worlds
  def index
    placeholder_set
    param_set
    @count	= World.notnil().includes(:pc_name).search(params[:q]).result.count()
    @search	= World.notnil().includes(:pc_name).page(params[:page]).search(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @worlds	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum('result_no')

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf('%d',@latest_result)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")

    checkbox_params_set_query(params, @form_params, query_name: "world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])
  end
  # GET /worlds/1
  #def show
  #end

  # GET /worlds/new
  #def new
  #  @world = World.new
  #end

  # GET /worlds/1/edit
  #def edit
  #end

  # POST /worlds
  #def create
  #  @world = World.new(world_params)

  #  if @world.save
  #    redirect_to @world, notice: 'World was successfully created.'
  #  else
  #    render action: 'new'
  #  end
  #end

  # PATCH/PUT /worlds/1
  #def update
  #  if @world.update(world_params)
  #    redirect_to @world, notice: 'World was successfully updated.'
  #  else
  #    render action: 'edit'
  #  end
  #end

  # DELETE /worlds/1
  #def destroy
  #  @world.destroy
  #  redirect_to worlds_url, notice: 'World was successfully destroyed.'
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_world
      @world = World.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def world_params
      params.require(:world).permit(:result_no, :generate_no, :e_no, :world)
    end
end
