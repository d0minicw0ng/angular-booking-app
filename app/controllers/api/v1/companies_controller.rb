class Api::V1::CompaniesController < ApplicationController

  def create
    company = CompanyCreator.create params[:company]
    render json: company.as_json, status: :ok
  end
end
