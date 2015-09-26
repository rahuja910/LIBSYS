class AdminsController < ApplicationController
	before_action :confirm_logged_in_admin  
   def index
	@admins=Admin.sorted
  end

  def show
	@admin=Admin.find(params[:id])
  end

  def new
	@admin=Admin.new
  end

  def create
	@admin=Admin.new(admin_params)
	if @admin.save
		flash[:notice]="Admin created successfully"
		redirect_to(:action => 'index')
	else
		render('new')
	end
  end

  def edit
	@admin=Admin.find(params[:id])
  end

  def update
	@admin=Admin.find(params[:id])
	if @admin.update_attributes(admin_params)
		flash[:notice]="Admin edited successfully"
		redirect_to(:action => 'show', :id => @admin.id)
	else
		render('edit')
	end
  end

  def delete
	@admin=Admin.find(params[:id])
  end

  def destroy
	admin=Admin.find(params[:id]).destroy
	flash[:notice] ="Admin '#{admin.name}' deleted successfully"
	redirect_to(:action => 'index')
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

  def add_book
	@book=Book.new
  end

  def create_book

	@book=Book.new(book_params)
	if @book.save
		flash[:notice]="Book created successfully"
		redirect_to(:action => 'manage_books')
	else
		render('add_book')
	end
  end

  def edit_book
	@book=Book.find(params[:id])
  end

  def update_book
	@book=Book.find(params[:id])
	if @book.update_attributes(book_update_params)
		flash[:notice]="Book edited successfully"
		redirect_to(:action => 'manage_books', :id => @book.id)
	else
		render('edit_book')
	end
  end

  def return_book
	@book=Book.find(params[:id])
	@borrow=BorrowBook.where(return_date:nil).where(book_id:@book.id)
	@member=Member.find(@borrow[0].member_id)
	@book.status="Available"
	time=Time.now
	@borrow[0].return_date=time.inspect
	if @borrow[0].save && @book.save
		flash[:notice]="Book Returned Successfully"
	else
		flash[:notice]="Book Return Failed"
	end
  end

  

  def delete_book
	@book=Book.find(params[:id])
  end

  def destroy_book
	book=Book.find(params[:id]).destroy
	flash[:notice] ="Book '#{book.title}' deleted successfully"
	redirect_to(:action => 'manage_books')
  end

  def show_book_history
	@book=Book.find(params[:id])
	@members=@book.members
  end

  def show_member_history
	@member=Member.find(params[:id])
	@books=@member.books
  end

  def manage_members
	@members=Member.sorted
  end

  def show_member
	@member=Member.find(params[:id])
    end

   def delete_member
	@member=Member.find(params[:id])
  end

  def destroy_member
	member=Member.find(params[:id]).destroy
	flash[:notice] ="Member '#{member.name}' deleted successfully"
	redirect_to(:action => 'manage_members')
  end
	


  private

  def admin_params
	params.require(:admin).permit(:email,:name,:password,:password_confirmation)
  end

  def book_params
	params.require(:book).permit(:ISBN,:title,:description,:authors)
  end

   def book_update_params
	params.require(:book).permit(:ISBN,:title,:description,:authors,:status)
  end

end
