class CardsController < ApplicationController
  include MyUtility
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # GET /cards
  def index
    resultno_set
    placeholder_set
    param_set

    @count  = Card.distinct.notnil().includes(:pc_name, :world, [skill: :timing], :party).search(params[:q]).result.count()
    @search = Card.distinct.notnil().includes(:pc_name, :world, [skill: :timing], :party).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @cards  = @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "made_e_no", params_name: "made_e_no_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_ep", params_name: "ep_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_text", params_name: "text_form", type: "text")

    params_to_form(params, @form_params, column_name: "skill_timing_name", params_name: "timing_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "skill_type_id_eq_any",
                             checkboxes: [{params_name: "type_active",   value: 0, first_checked: true},
                                          {params_name: "type_passive" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "skill_element_id_eq_any",
                             checkboxes: [{params_name: "element_none",   value: 0},
                                          {params_name: "element_fire",   value: 1},
                                          {params_name: "element_water",  value: 2},
                                          {params_name: "element_wind",   value: 3},
                                          {params_name: "element_ground", value: 4},
                                          {params_name: "element_light",  value: 5},
                                          {params_name: "element_dark",   value: 6}])
    
    pm_matching(params, @form_params)

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_skill")
    toggle_params_to_variable(params, @form_params, params_name: "show_skill_text")
    toggle_params_to_variable(params, @form_params, params_name: "show_card_name", first_opened: true)
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /cards/1
  #def show
  #end

  # GET /cards/new
  #def new
  #  @card = Card.new
  #end

  # GET /cards/1/edit
  #def edit
  #end

  # POST /cards
  #def create
  #  @card = Card.new(card_params)

  #  if @card.save
  #    redirect_to @card, notice: "Card was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /cards/1
  #def update
  #  if @card.update(card_params)
  #    redirect_to @card, notice: "Card was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /cards/1
  #def destroy
  #  @card.destroy
  #  redirect_to cards_url, notice: "Card was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def card_params
      params.require(:card).permit(:result_no, :generate_no, :e_no, :name, :skill_id, :made_e_no)
    end
end
