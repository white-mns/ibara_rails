class PartiesController < ApplicationController
  include MyUtility
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  # GET /parties
  def index
    placeholder_set
    param_set
    @count	= Party.notnil().includes(:pc_name, :world).search(params[:q]).result.count()
    @search	= Party.notnil().includes(:pc_name, :world).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @parties	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
        params["pm_result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_type", params_name: "party_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "party", params_name: "party_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "party_type_eq_any",
                             checkboxes: [{params_name: "is_battle", value: 0, first_checked: true},
                                          {params_name: "is_next" ,  value: 1, first_checked: true}])
    # キャラ周囲絞り込み用
    params2 = {}
    params2[:q] = {}
    params2["is_form"] = "1"
    params2["pm_result_no_form"] = params["pm_result_no_form"]
    params2["pm_e_no_form"] = params["pm_e_no_form"]
    params2["pm_pc_name_form"] = params["pm_pc_name_form"]
    params2["pm_party_type_form"] = params["pm_party_type_form"]
    params2["pm_battle"] = params["pm_battle"]
    params2["pm_next"]   = params["pm_next"]

    params_to_form(params2, @form_params, column_name: "result_no", params_name: "pm_result_no_form", type: "number")
    params_to_form(params2, @form_params, column_name: "e_no", params_name: "pm_e_no_form", type: "number")
    params_to_form(params2, @form_params, column_name: "pc_name_name", params_name: "pm_pc_name_form", type: "text")
    checkbox_params_set_query_any(params2, @form_params, query_name: "party_type_eq_any",
                             checkboxes: [{params_name: "pm_battle", value: 0, first_checked: false},
                                          {params_name: "pm_next" ,  value: 1, first_checked: true}])

    if params["pm_e_no_form"] || params["pm_pc_name_form"]
        party_member_array = Party.pc_to_party_member_array(params2)
        params[:q]["party_eq_any"] = party_member_array.uniq
    end
    
    # フォームに値を受け渡す用の空実行
    checkbox_params_set_query_any(params, @form_params, query_name: "xxx",
                             checkboxes: [{params_name: "pm_battle", value: 0, first_checked: false},
                                          {params_name: "pm_next" ,  value: 1, first_checked: true}])

    @form_params["pm_result_no_form"] = params["pm_result_no_form"]
    @form_params["pm_e_no_form"] = params["pm_e_no_form"]
    @form_params["pm_pc_name_form"] = params["pm_pc_name_form"]
    @form_params["pm_battle"] = params["pm_battle"]
    @form_params["pm_next"] = params["pm_next"]

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_pm")
  end
  # GET /parties/1
  #def show
  #end

  # GET /parties/new
  #def new
  #  @party = Party.new
  #end

  # GET /parties/1/edit
  #def edit
  #end

  # POST /parties
  #def create
  #  @party = Party.new(party_params)

  #  if @party.save
  #    redirect_to @party, notice: "Party was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /parties/1
  #def update
  #  if @party.update(party_params)
  #    redirect_to @party, notice: "Party was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /parties/1
  #def destroy
  #  @party.destroy
  #  redirect_to parties_url, notice: "Party was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def party_params
      params.require(:party).permit(:result_no, :generate_no, :e_no, :party_type, :party)
    end
end
