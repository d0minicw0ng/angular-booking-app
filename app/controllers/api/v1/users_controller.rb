class Api::V1::UsersController < ApplicationController

  before_action :authenticate_current_user

  ["employees", "customers"].each do |role|

    define_method role do
      company = Company.find @current_user.company_id
      render json: company.send(role), status: :ok
    end

    define_method "top_#{role}" do
      company = Company.find @current_user.company_id
      top_users = company.send "top_#{role}", {
        limit: params[:limit],
        year: params[:year],
        month: params[:month]
      }

      render json: top_users, status: :ok
    end
  end

end
