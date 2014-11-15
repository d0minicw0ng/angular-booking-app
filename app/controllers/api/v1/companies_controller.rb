class Api::V1::CompaniesController < ApplicationController

  def create
    employee_id = params[:company][:employee_id]
    company = Company.new company_params
    company.employee_ids << employee_id
    company.save
    render json: company.as_json, status: :ok
  end

  private

  def company_params
    params.require(:company).permit :name
  end

end
