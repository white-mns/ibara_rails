class PartyInfosController < ApplicationController
  include MyUtility
  before_action :set_party_info, only: [:show, :edit, :update, :destroy]

  # GET /party_infos
  def index
    placeholder_set
    param_set
    @count	= PartyInfo.notnil().includes(:world, [party_members: :pc_name], :place).ransack(params[:q]).result.count()
    @search	= PartyInfo.notnil().includes(:world, [party_members: :pc_name], :place).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @party_infos	= @search.result.per(50)
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

    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_no", params_name: "party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_type", params_name: "party_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "number")
    params_to_form(params, @form_params, column_name: "member_num", params_name: "member_num_form", type: "number")

    params_to_form(params, @form_params, column_name: "party_members_e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_members_pc_name_name", params_name: "pc_name_form", type: "text")

    params_to_form(params, @form_params, column_name: "place_area_column", params_name: "area_column_form", type: "text")
    params_to_form(params, @form_params, column_name: "place_area_row", params_name: "area_row_form", type: "number")
    params_to_form(params, @form_params, column_name: "place_field_name", params_name: "field_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "party_type_eq_any",
                             checkboxes: [{params_name: "is_battle", value: 0},
                                          {params_name: "is_next" ,  value: 1, first_checked: true}])

    girth_matching(params, @form_params)

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
  end
  # GET /party_infos/1
  #def show
  #end

  # GET /party_infos/new
  #def new
  #  @party_info = PartyInfo.new
  #end

  # GET /party_infos/1/edit
  #def edit
  #end

  # POST /party_infos
  #def create
  #  @party_info = PartyInfo.new(party_info_params)

  #  if @party_info.save
  #    redirect_to @party_info, notice: "Party info was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /party_infos/1
  #def update
  #  if @party_info.update(party_info_params)
  #    redirect_to @party_info, notice: "Party info was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /party_infos/1
  #def destroy
  #  @party_info.destroy
  #  redirect_to party_infos_url, notice: "Party info was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party_info
      @party_info = PartyInfo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def party_info_params
      params.require(:party_info).permit(:result_no, :generate_no, :party_no, :party_type, :name, :member_num)
    end
end
