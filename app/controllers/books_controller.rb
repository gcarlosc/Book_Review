class BooksController < ApplicationController
  before_action :find_books, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    @books = Book.all.order("created_at DESC")
  end

  def new
    @book = current_user.books.build
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @book = current_user.books.build(books_params)
    @book.category_id = params[:category_id]
    if @book.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def update
    @book.category_id = params[:category_id]
    if @book.update(books_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to root_path
  end

  private

  def books_params
    params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
  end

  def find_books
    @book = Book.find(params[:id])
  end
end
