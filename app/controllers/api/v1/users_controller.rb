class Api::V1::UsersController < ApplicationController

  # TODO: There is a bug in devise_token_auth that makes
  # current_user returns false, I need to find out what it is
  # ASAP because using params[:company_id] is very insecure
  # and anyone can send a GET request to get employees data
  # of ANY company.
  #
  # before_action :authenticate_user!

  def index
    employees = User.where(company_id: params[:company_id])
    render json: employees, status: :ok
  end
end
