class Member < ActiveRecord::Base
	has_many :borrow_books
	has_many :books , :through => :borrow_books

	has_secure_password

	scope :sorted, lambda {order ("members.created_at ASC")}


	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	validates_uniqueness_of :email
	validates_length_of :email , :maximum => 50
	validates_presence_of :email
	validates_presence_of :name
	validates_length_of :name , :maximum => 50
	validates_length_of :password , :within => 6..20

end
