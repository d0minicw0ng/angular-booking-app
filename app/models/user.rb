class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  # TODO: validates_presence_of :name OR (:first_name and :last_name)?
  # TODO: This does not apply to customers!
  # It needs a `where` scope when we introduce user types
  belongs_to :company
end
