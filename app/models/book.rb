class Book < ActiveRecord::Base
	has_many :borrow_books
	has_many :members, :through => :borrow_books

scope :sorted, lambda {order ("books.created_at ASC")}
scope :searchTitle, lambda {|query|
where (["title LIKE ?", "%#{query}%"])}

scope :searchISBN, lambda {|query|
where (["ISBN LIKE ?", "%#{query}%"])}

scope :searchAuthors, lambda {|query|
where (["authors LIKE ?", "%#{query}%"])}

scope :searchDescription, lambda {|query|
where (["description LIKE ?", "%#{query}%"])}

scope :searchStatus, lambda {|query|
where (["status LIKE ?", "%#{query}%"])}

scope :searchBooks, lambda {|query|
where (["id EQUAL ?", "%#{query}%"])}


validates_uniqueness_of :ISBN
validates_presence_of :ISBN
validates_numericality_of :ISBN
validates_presence_of :title
validates_length_of :title , :maximum => 50
validates_length_of :description , :maximum => 255
validates_length_of :authors , :maximum => 50

end
