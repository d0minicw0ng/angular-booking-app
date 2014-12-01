class Company < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :employees, -> { where("role != 'customer'") }, class_name: "User"
  has_many :customers, -> { where("role = 'customer'") }, class_name: "User"

  ["employees", "customers"].each do |role|
    define_method "top_#{role}" do |options|
      if role == "employees"
        count = "jobs_count"
        role_query = "users.role != 'customer'"
        join_table = :jobs
      else
        count = "appointments_count"
        role_query = "users.role = 'customer'"
        join_table = :appointments
      end

      limit = options[:limit] || 10
      if options[:year] && options[:month]
        month = DateTime.new options[:month]
      else
        month = DateTime.new(DateTime.now.year, DateTime.now.month, 1)
      end

      User.joins(join_table)
        .where(
          "users.company_id = ? AND #{role_query} AND appointments.start_time >= ? AND appointments.start_time <= ?",
          self.id, month, month + 1.month
        )
        .select("users.*, COUNT(users.id) AS #{count}")
        .group("users.id")
        .order("#{count} DESC")
        .limit(limit)
    end

  end
end
