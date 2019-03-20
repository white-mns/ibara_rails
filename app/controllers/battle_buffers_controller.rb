class BattleBuffersController < ApplicationController
  include MyUtility
  before_action :set_battle_buffer, only: [:show, :edit, :update, :destroy]

  # GET /battle_buffers
  def index
    placeholder_set
    param_set
    @count	= BattleBuffer.notnil().includes(:battle_info, :buffer).search(params[:q]).result.hit_count()
    @search	= BattleBuffer.notnil().includes(:battle_info, :buffer).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @battle_buffers	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_id", params_name: "battle_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "act_id", params_name: "act_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "act_sub_id", params_name: "act_sub_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "buffer_type", params_name: "buffer_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "value", params_name: "value_form", type: "number")

    params_to_form(params, @form_params, column_name: "buffer_name", params_name: "buffer_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
  end
  # GET /battle_buffers/1
  #def show
  #end

  # GET /battle_buffers/new
  #def new
  #  @battle_buffer = BattleBuffer.new
  #end

  # GET /battle_buffers/1/edit
  #def edit
  #end

  # POST /battle_buffers
  #def create
  #  @battle_buffer = BattleBuffer.new(battle_buffer_params)

  #  if @battle_buffer.save
  #    redirect_to @battle_buffer, notice: "Battle buffer was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /battle_buffers/1
  #def update
  #  if @battle_buffer.update(battle_buffer_params)
  #    redirect_to @battle_buffer, notice: "Battle buffer was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /battle_buffers/1
  #def destroy
  #  @battle_buffer.destroy
  #  redirect_to battle_buffers_url, notice: "Battle buffer was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_buffer
      @battle_buffer = BattleBuffer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_buffer_params
      params.require(:battle_buffer).permit(:result_no, :generate_no, :battle_id, :act_id, :act_sub_id, :buffer_type, :value)
    end
end
