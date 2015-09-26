class AddPasswordDigestReturnDate < ActiveRecord::Migration
  def change
	remove_column("admins","password")
	add_column("admins","password_digest", :string)

	remove_column("members","password")
	add_column("members","password_digest", :string)

	add_column("borrow_books","return_date", :date)	
  end
end
