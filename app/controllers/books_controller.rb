class BooksController < ApplicationController

    def new
    end

    def create
      @book_new = Book.new(book_params)
      @book_new.user_id = current_user.id
      if
        @book_new.save
        redirect_to book_path(@book_new.id)
        flash[:notice] = "You have created book successfully."
      else
        @books = Book.all
        @user = current_user
        render 'index'
      end
    end

    def index
      @books = Book.all
      @book_new = Book.new
      @user = current_user
    end

    def show
      @book = Book.find(params[:id])
      @user = @book.user
      @book_new = Book.new
      @book_comment = BookComment.new
    end

    def edit
      @book = Book.find(params[:id])
      if
        @book.user == current_user
        render 'edit'
      else
        redirect_to books_path
      end
    end

    def update
      @book = Book.find(params[:id])
      if
        @book.update(book_params)
        redirect_to book_path(@book.id)
        flash[:notice] = "You have updated book successfully."
      else
        render 'edit'
      end
    end

    def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path
    end

    private
    def book_params
      params.require(:book).permit(:title, :body, )
    end
end