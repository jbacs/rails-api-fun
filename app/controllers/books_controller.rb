class BooksController < ApplicationController
  def index
    books = Book.all
    render json: BookSerializer.new(books).serializable_hash.to_json, status: :ok
  end

  def create
    author = Author.create(author_params)
    book = Book.new(book_params.merge(author_id: author.id))

    if book.save
      render json: BookSerializer.new(book).serializable_hash.to_json, status: :created
    else
      render json: { error: book.errors }, status: :unprocessable_entity
    end
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name, :age)
  end

  def book_params
    params.require(:book).permit(:title)
  end
end
