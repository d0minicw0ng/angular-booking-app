class Appointment < ActiveRecord::Base

  belongs_to :masseur, class_name: "User"
  belongs_to :customer, class_name: "User"

  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :masseur_id
  validates_presence_of :customer_id

  validate :start_time_after_current_datetime
  validate :start_time_before_end_time
  validate :masseur_does_not_have_conflicting_appointments
  validate :customer_does_not_have_conflicting_appointments

  def self.of_company company_id
    self.joins(:masseur)
      .where "users.company_id = ?", company_id
  end

  private

  def masseur_does_not_have_conflicting_appointments
    start_time_conflicting_appointments =
      Appointment.where(start_time: start_time..end_time, masseur_id: masseur_id)
    end_time_conflicting_appointments =
     Appointment.where(end_time: start_time..end_time, masseur_id: masseur_id)

    # New appointment
    if !id && (start_time_conflicting_appointments.count > 0 || end_time_conflicting_appointments.count > 0)
      errors.add :masseur_id, "There is an appointment conflict."
      return
    end

    # Update appointment
    if id.present? && (
       start_time_conflicting_appointments.count > 1 ||
       end_time_conflicting_appointments.count > 1 ||
       (start_time_conflicting_appointments.count == 1 && start_time_conflicting_appointments[0].id != id) ||
       (end_time_conflicting_appointments.count == 1 && end_time_conflicting_appointments[0].id != id))

      errors.add :masseur_id, "There is an appointment conflict."
    end
  end

  def customer_does_not_have_conflicting_appointments
    start_time_conflicting_appointments =
      Appointment.where(start_time: start_time..end_time, customer_id: customer_id)
    end_time_conflicting_appointments =
     Appointment.where(end_time: start_time..end_time, customer_id: customer_id)

    if !id && (start_time_conflicting_appointments.count > 0 || end_time_conflicting_appointments.count > 0)
      errors.add :customer_id, "There is an appointment conflict."
      return
    end

    if id.present? && (
       start_time_conflicting_appointments.count > 1 ||
       end_time_conflicting_appointments.count > 1 ||
       (start_time_conflicting_appointments.count == 1 && start_time_conflicting_appointments[0].id != id) ||
       (end_time_conflicting_appointments.count == 1 && end_time_conflicting_appointments[0].id != id))

      errors.add :customer_id, "There is an appointment conflict."
    end
  end

  def start_time_after_current_datetime
    errors.add :start_time, "can't be before current time." if start_time < DateTime.now
  end

  def start_time_before_end_time
    errors.add :end_time, "can't be before start time." if start_time > end_time
  end

  def serializable_hash options
    options ||= {
      include: {
        masseur: {
          only: [:id],
          methods: [:name]
        },
        customer: {
          only: [:id],
          methods: [:name]
        }
      }
    }
    super options
  end
end
