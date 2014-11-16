class Company < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :employees, -> { where("role != 'customer'") }, class_name: "User"
  has_many :customers, -> { where("role = 'customer'") }, class_name: "User"

end
