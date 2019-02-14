class NamesController < ApplicationController
  include MyUtility
  before_action :set_name, only: [:show, :edit, :update, :destroy]

  # GET /names
  def index
    placeholder_set
    param_set
    @count	= Name.notnil().search(params[:q]).result.count()
    @search	= Name.notnil().page(params[:page]).search(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @names	= @search.result.per(50)
  end

  def param_set
    @latest_result = Name.maximum('result_no')

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf('%d',@latest_result)
    end
    
    reference_text_assign(params, "name", "pc_name_form")
    reference_number_assign(params, "result_no", "result_no_form")
    reference_number_assign(params, "generate_no", "generate_no_form")
    reference_number_assign(params, "e_no", "e_no_form")
    reference_text_assign(params, "player", "player_form")
    
    @pc_name_form = params["pc_name_form"]
    @result_no_form = params["result_no_form"]
    @generate_no_form = params["generate_no_form"]
    @e_no_form = params["e_no_form"]
    @name_form = params["name_form"]
    @player_form = params["player_form"]
  end
  # GET /names/1
  #def show
  #end

  # GET /names/new
  #def new
  #  @name = Name.new
  #end

  # GET /names/1/edit
  #def edit
  #end

  # POST /names
  #def create
  #  @name = Name.new(name_params)

  #  if @name.save
  #    redirect_to @name, notice: 'Name was successfully created.'
  #  else
  #    render action: 'new'
  #  end
  #end

  # PATCH/PUT /names/1
  #def update
  #  if @name.update(name_params)
  #    redirect_to @name, notice: 'Name was successfully updated.'
  #  else
  #    render action: 'edit'
  #  end
  #end

  # DELETE /names/1
  #def destroy
  #  @name.destroy
  #  redirect_to names_url, notice: 'Name was successfully destroyed.'
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_name
      @name = Name.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def name_params
      params.require(:name).permit(:result_no, :generate_no, :e_no, :name, :player)
    end
end
