# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[edit update]

  def index
    @books = Book.search(params[:q])
  end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to books_url, notice: "Book was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      redirect_to books_url, notice: "Book was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description, :author, :genre)
  end
end
