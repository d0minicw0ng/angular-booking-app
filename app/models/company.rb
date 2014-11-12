class Company < ActiveRecord::Base
  # TODO: This does not apply to customers!
  # It needs a `where` scope when we introduce user types
  has_many :employees, class_name: "User"
end
