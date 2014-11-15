class Api::V1::AppointmentsController < ApplicationController

  before_action :authenticate_current_user

  def index
    appointments = Appointment
      .joins(:masseur)
      .where "user.company_id = ?", @current_user.company_id

    render json: appointments.as_json, status: :ok
  end

  def create
  end
end
