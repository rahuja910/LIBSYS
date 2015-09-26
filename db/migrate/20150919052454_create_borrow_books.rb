class CreateBorrowBooks < ActiveRecord::Migration
  def up
    create_table :borrow_books do |t|
	t.references :member
	t.references :book
	t.date "borrow_date"
	t.timestamps
    end
	add_index :borrow_books, ["member_id", "book_id"]
  end

	def down
		drop_table :borrow_books
	end
end
