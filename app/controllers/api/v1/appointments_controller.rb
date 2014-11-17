class Api::V1::AppointmentsController < ApplicationController

  before_action :authenticate_current_user

  def index
    appointments = Appointment
      .joins(:masseur)
      .where "users.company_id = ?", @current_user.company_id

    render json: appointments.as_json, status: :ok
  end

  def create
    appointment = Appointment.create appointment_params
    render json: appointment.as_json, status: :ok
  end

  private

  def appointment_params
    params.require(:appointment).permit :start_time, :end_time, :masseur_id, :customer_id
  end
end
