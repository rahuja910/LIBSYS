class Admin < ActiveRecord::Base

scope :sorted, lambda {order ("admins.created_at ASC")}

has_secure_password

validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
validates_uniqueness_of :email
validates_length_of :email , :maximum => 50
validates_presence_of :email
validates_presence_of :name
validates_length_of :name , :maximum => 50
#validates_presence_of :password
validates_length_of :password , :within => 6..20
#validates_confirmation_of :password

end
