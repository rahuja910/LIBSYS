class MembersController < ApplicationController

	before_action :confirm_logged_in , :except => [:new,:create]

	def return_book
		@member=Member.find(params[:user_id])
		@book=Book.find(params[:id])
		@book.status="Available"
		@borrow=BorrowBook.where(return_date:nil).where(book_id:@book.id)
		#@borrow=BorrowBook.find_by_book_id(@book.id)
		time=Time.now
		@borrow[0].return_date=time.inspect
		if @borrow[0].save && @book.save
			flash[:notice]="Book Returned Successfully"
		else
			flash[:notice]="Book Return Failed"
		end
	end

	def view_history
		@member=Member.find(params[:user_id])
		@books=@member.books
	end

	def search_books
		if (params[:search_option])=="Title"
		@books = Book.searchTitle params[:search_book]
		elsif (params[:search_option])=="ISBN"
		@books = Book.searchISBN params[:search_book]
		elsif (params[:search_option])=="Authors"
		@books = Book.searchAuthors params[:search_book]
		elsif (params[:search_option])=="Description"
		@books = Book.searchDescription params[:search_book]
		elsif (params[:search_option])=="Status"
		@books = Book.searchStatus params[:search_book]		
		end
	end

	def checkout_book
		@member=Member.find(params[:user_id])
		@book=Book.find(params[:book_id])
		@book.status="Checked Out"
		@borrow=BorrowBook.new
		@borrow.member_id=@member.id
		@borrow.book_id=@book.id
		time=Time.now
		@borrow.borrow_date=time.inspect
		if @borrow.save && @book.save
		flash[:notice]="Book Checkout Successfull"
		render('show')
		else
		#flash[:notice]="Book Checkout Failed"
		render('manage_books')	
	end
	end


	

	def index
	@member=Member.find(session[:user_id])
	@books=@member.books
	end

	def show
	@member=Member.find(params[:id])
  	end

	def edit
	@member=Member.find(params[:id])
	end

  	def update
	@member=Member.find(params[:id])
	if @member.update_attributes(member_params)
		flash[:notice]="Member edited successfully"
		redirect_to(:action => 'show', :id => @member.id)
	else
		render('edit')
	end
	end

	def manage_books
	@books=Book.sorted
	end
	
	def show_book
	@book=Book.find(params[:id])
	@borrow=BorrowBook.find_by_book_id(@book.id)
	if(@borrow!=nil) then 
	@member=Member.find(@borrow.member_id)
	end	
	end

	 def new
	      @member=Member.new
 	 end

        def create
	@member=Member.new(member_params)
	if @member.save
		flash[:notice]="Member created successfully"
		redirect_to({:controller =>'access',:action => 'login'})
	else
		render('new')
	end

 	end



	private

  	def member_params
	params.require(:member).permit(:email,:name,:password,:password_confirmation)
 	end
	def book_params
	params.require(:book).permit(:title)
  	end

end
