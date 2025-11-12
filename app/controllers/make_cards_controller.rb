class MakeCardsController < ApplicationController
  include MyUtility
  before_action :set_make_card, only: [:show, :edit, :update, :destroy]

  # GET /make_cards
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = MakeCard.notnil().includes(:pc_name, :world, :receiver).ransack(params[:q]).result.hit_count()
    @search = MakeCard.notnil().includes(:pc_name, :world, :receiver).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @make_cards = @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
      params["result_no_form"] ||= sprintf("~%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "receive_e_no", params_name: "receive_e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_ep", params_name: "ep_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_text", params_name: "text_form", type: "text")

    params_to_form(params, @form_params, column_name: "skill_timing_name", params_name: "timing_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /make_cards/1
  #def show
  #end

  # GET /make_cards/new
  #def new
  #  @make_card = MakeCard.new
  #end

  # GET /make_cards/1/edit
  #def edit
  #end

  # POST /make_cards
  #def create
  #  @make_card = MakeCard.new(make_card_params)

  #  if @make_card.save
  #    redirect_to @make_card, notice: "Make card was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /make_cards/1
  #def update
  #  if @make_card.update(make_card_params)
  #    redirect_to @make_card, notice: "Make card was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /make_cards/1
  #def destroy
  #  @make_card.destroy
  #  redirect_to make_cards_url, notice: "Make card was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_make_card
      @make_card = MakeCard.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def make_card_params
      params.require(:make_card).permit(:result_no, :generate_no, :e_no, :receiver_e_no, :name, :skill_id, :card_no)
    end
end
