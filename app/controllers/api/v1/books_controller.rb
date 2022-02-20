class Api::V1::BooksController < Api::V1::BaseController
  def index
    books = Book.all
    success_response BookSerializer.new(books).serializable_hash.to_json
  end

  def create
    author = Author.create(author_params)
    book = Book.new(book_params.merge(author_id: author.id))

    if book.save
      success_response BookSerializer.new(book).serializable_hash.to_json, :created
    else
      error_response({ error: book.errors }, :unprocessable_entity)
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
