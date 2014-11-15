class Api::V1::UsersController < ApplicationController

  before_action :authenticate_current_user

  def index
    employees = User.where company_id: @current_user.company_id
    render json: employees, status: :ok
  end
end
