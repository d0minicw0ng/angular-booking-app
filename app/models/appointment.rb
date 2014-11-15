class Appointment < ActiveRecord::Base

  belongs_to :masseur, class_name: "User"
  belongs_to :customer, class_name: "User"

  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :masseur_id
  validates_presence_of :customer_id

  validate :start_time_after_current_datetime
  validate :start_time_before_end_time

  private

  def start_time_after_current_datetime
    errors.add :start_time, "can't be before current time." if start_time < DateTime.now
  end

  def start_time_before_end_time
    errors.add :start_time, "can't be after end time." if start_time < end_time
  end
end
