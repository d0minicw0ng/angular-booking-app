class Company < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  # TODO: This does not apply to customers!
  # It needs a `where` scope when we introduce user types
  has_many :employees, class_name: "User"
end
