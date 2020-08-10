class SuperpowersController < ApplicationController
  include MyUtility
  before_action :set_superpower, only: [:show, :edit, :update, :destroy]

  # GET /superpowers
  def index
    placeholder_set
    param_set
    @count	= Superpower.distinct.notnil().includes(:pc_name, :world, :superpower, :place, :party).search(params[:q]).result.count()
    @search	= Superpower.distinct.notnil().includes(:pc_name, :world, :superpower, :place, :party).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @superpowers	= @search.result.per(50)
  end

  # GET /superpower/combinations
  def combination
    @superpower_datas = Skill.superpower_datas
    placeholder_set
    param_set_combination
    @count	= Skill.distinct.notnil().combination_includes(params, @superpower_datas).combination_groups(params).search(params[:q]).result.hit_count()
    @search	= Skill.distinct.notnil().combination_includes(params, @superpower_datas).combination_groups(params).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @superpowers	= @search.result.per(50)
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

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "superpower_id", params_name: "superpower_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "lv", params_name: "lv_form", type: "number")

    params_to_form(params, @form_params, column_name: "superpower_name", params_name: "superpower_form", type: "text")

    params_to_form(params, @form_params, column_name: "place_area_column", params_name: "area_column_form", type: "text")
    params_to_form(params, @form_params, column_name: "place_area_row", params_name: "area_row_form", type: "number")
    params_to_form(params, @form_params, column_name: "place_field_name", params_name: "field_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])
    
    girth_matching(params, @form_params)
    pm_matching(params, @form_params)
    
    # toggle操作用
    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
  end

  def param_set_combination
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    if !params["is_form"] then
        params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    if params["area_column_form"] then
        params["area_column_form"].upcase!
    end


    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "superpower_id", params_name: "superpower_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "lv", params_name: "lv_form", type: "number")

    blank_superpowers = []

    @superpower_datas.each do |superpower_data|
        if params[superpower_data[:en] + "_form"] == "0" then
            params.delete((superpower_data[:en] + "_form").to_sym)
            params[:q][superpower_data[:en] + "_lv_blank"] = true
            blank_superpowers.push(superpower_data[:en])
        end

        params_to_form(params, @form_params, column_name: superpower_data[:en] + "_lv", params_name: superpower_data[:en] + "_form", type: "number")
    end

    blank_superpowers.each do |blank|
        @form_params[blank + "_form"] = "0"
    end


    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")

    params_to_form(params, @form_params, column_name: "place_area_column", params_name: "area_column_form", type: "text")
    params_to_form(params, @form_params, column_name: "place_area_row", params_name: "area_row_form", type: "number")
    params_to_form(params, @form_params, column_name: "place_field_name", params_name: "field_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "world_world_eq_any",
                             checkboxes: [{params_name: "is_ibaracity", value: 0, first_checked: true},
                                          {params_name: "is_ansinity" , value: 1, first_checked: true}])
    
    girth_matching(params, @form_params)
    pm_matching(params, @form_params)
    
    # toggle操作用
    toggle_params_to_variable(params, @form_params, params_name: "show_world")
    toggle_params_to_variable(params, @form_params, params_name: "show_place")
    toggle_params_to_variable(params, @form_params, params_name: "show_superpower", first_opened: true)
    toggle_params_to_variable(params, @form_params, params_name: "show_skill")
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
