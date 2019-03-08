class TopPageController < ApplicationController
  def index
    @latest_result = Name.maximum("result_no")
    @latest_generate = Name.where(result_no: @latest_result).maximum("generate_no")
    @uploaded_result = UploadedCheck.maximum("result_no")
  end
end
