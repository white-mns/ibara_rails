class CompoundsController < ApplicationController
  include MyUtility
  before_action :set_compound, only: [:show, :edit, :update, :destroy]

  # GET /compounds
  def index
    resultno_set
    placeholder_set
    param_set

    @count	= Compound.notnil().includes(:pc_name, :world, :compound_result).compound_includes(params).groups(params).search(params[:q]).result.count().keys().size
    @search	= Compound.notnil().includes(:pc_name, :world, :compound_result).compound_includes(params).groups(params).for_group_select(params).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @compounds	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "last_result_no", params_name: "last_result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "last_generate_no", params_name: "last_generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "source_1_i_no", params_name: "source_1_i_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "source_1_name", params_name: "source_1_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "source_2_i_no", params_name: "source_2_i_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "source_2_name", params_name: "source_2_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "sources_name", params_name: "sources_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "is_success", params_name: "is_success_form", type: "number")
    params_to_form(params, @form_params, column_name: "compound_result_id", params_name: "compound_result_id_form", type: "number")
    
    params_to_form(params, @form_params, column_name: "source_1_name_or_source_2_name", params_name: "source_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "compound_result_name", params_name: "compound_result_form", type: "text")
    params_to_form(params, @form_params, column_name: "compound_lv", params_name: "compound_lv_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "is_success_eq_any",
                             checkboxes: [{params_name: "compound_success",       value: 1,  first_checked: true},
                                          {params_name: "compound_test_success",  value: 2,  first_checked: true},
                                          {params_name: "compound_deficient_lv",  value: -1, first_checked: true},
                                          {params_name: "compound_nihility",      value: -2}])

    @form_params["group_result"] = params["group_result"]
    @form_params["group_source"] = params["group_source"]

    toggle_params_to_variable(params, @form_params, params_name: "show_world")
  end
  # GET /compounds/1
  #def show
  #end

  # GET /compounds/new
  #def new
  #  @compound = Compound.new
  #end

  # GET /compounds/1/edit
  #def edit
  #end

  # POST /compounds
  #def create
  #  @compound = Compound.new(compound_params)

  #  if @compound.save
  #    redirect_to @compound, notice: "Compound was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /compounds/1
  #def update
  #  if @compound.update(compound_params)
  #    redirect_to @compound, notice: "Compound was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /compounds/1
  #def destroy
  #  @compound.destroy
  #  redirect_to compounds_url, notice: "Compound was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compound
      @compound = Compound.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def compound_params
      params.require(:compound).permit(:result_no, :generate_no, :e_no, :last_result_no, :last_generate_no, :source_1_i_no, :source_1_name, :source_2_i_no, :source_2_name, :is_success, :compound_result_id)
    end
end
