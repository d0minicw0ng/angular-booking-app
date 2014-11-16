class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  belongs_to :company

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_inclusion_of :role, in: %w(admin manager staff customer)

  # TODO: more attributes
  # address
  # department / type
  # emergency contact
  # photo
  # pay rate
  # maybe start date/ hire date?
end
