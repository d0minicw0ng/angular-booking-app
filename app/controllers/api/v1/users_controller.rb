class Api::V1::UsersController < ApplicationController

  before_action :authenticate_current_user

  def employees
    company = Company.find @current_user.company_id
    render json: company.employees, status: :ok
  end

  def customers
    company = Company.find @current_user.company_id
    render json: company.customers, status: :ok
  end

end
