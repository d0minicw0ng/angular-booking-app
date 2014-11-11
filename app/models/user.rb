class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  # TODO: validates_presence_of :first_name and :last_name?
end
