class Api::V1::AppointmentsController < ApplicationController

  before_action :authenticate_current_user

  def index
    appointments = Appointment.of_company @current_user.company_id
    render json: appointments.as_json, status: :ok
  end

  def create
    appointment = Appointment.new appointment_params

    if appointment.save
      render json: appointment.as_json, status: :ok
    else
      render json: { errors: appointment.errors.as_json }, status: :unprocessable_entity
    end
  end

  def update
    appointment = Appointment.find params[:id]

    if appointment.update_attributes appointment_params
      render json: appointment.as_json, status: :ok
    else
      render json: { errors: appointment.errors.as_json }, status: :unprocessable_entity
    end

  end

  def destroy
    appointment = Appointment.find params[:id]
    appointment.destroy
    head :ok
  end

  private

  def appointment_params
    params.require(:appointment).permit :start_time, :end_time, :masseur_id, :customer_id
  end
end
