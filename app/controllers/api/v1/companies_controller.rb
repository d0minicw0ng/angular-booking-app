class Api::V1::CompaniesController < ApplicationController

  def create
    # TODO: service?
    company = Company.new company_params
    employee = User.find params[:company][:employee_id]
    ActiveRecord::Base.transaction do
      company.save
      employee.update_attributes company_id: company.id
    end
    # TODO: Will it fail if it's not valid? Refer to appointments_controller
    render json: company.as_json
  end

  private

  def company_params
    params.require(:company).permit :name
  end

end
