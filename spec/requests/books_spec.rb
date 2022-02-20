require 'rails_helper'

RSpec.describe 'Books', type: :request do
  let(:author) { create :author }
  let(:book1) { create :book, author: author }
  let(:book2) { create :book, author: author }

  describe 'GET /books' do
    before do
      book1
      book2
    end

    it 'returns http status of :ok' do
      get '/books'
      expect(response).to have_http_status :ok
    end

    it 'returns all books' do
      get '/books'
      expect(response_body).to eq(
        {
          'data' => [
            { 'attributes' => { 'title' => book1.title }, 'id' => book1.id.to_s, 'type' => 'book' },
            { 'attributes' => { 'title' => book2.title }, 'id' => book2.id.to_s, 'type' => 'book' }
          ]
        }
      )
    end

    it 'returns a subset of books based on limit' do
      get '/books', params: { limit: 1 }
      expect(response_body).to eq(
        {
          'data' => [
            { 'attributes' => { 'title' => book1.title }, 'id' => book1.id.to_s, 'type' => 'book' }
          ]
        }
      )
    end

    it 'returns a subset of books based on limit and offset' do
      get '/books', params: { limit: 1, offset: 1 }
      expect(response_body).to eq(
        {
          'data' => [
            { 'attributes' => { 'title' => book2.title }, 'id' => book2.id.to_s, 'type' => 'book' }
          ]
        }
      )
    end
  end

  describe 'POST /books' do
    let(:author_build) { build :author }
    let(:book_build) { build :book }
    let(:book_post_request) do
      post '/books', params: { 
        book: { title: book_build.title },
        author: { first_name: author_build.first_name, last_name: author_build.last_name, age: author_build.age }
      }
    end

    it 'returns http status of :created' do
      book_post_request
      expect(response).to have_http_status :created
    end

    it 'creates new book' do
      expect {
        book_post_request
      }.to change { Book.count }.from(0).to(1)
    end

    it 'creates new author' do
      expect {
        book_post_request
      }.to change { Author.count }.from(0).to(1)
    end

    it 'returns newly created book' do
      book_post_request
      book = Book.last
      expect(response_body).to eq(
        {
          'data' => { 'attributes' => { 'title' => book.title }, 'id' => book.id.to_s, 'type' => 'book' }
        }
      )
    end
  end

  describe 'DELETE /books/:id' do
    let(:book_delete_request) { delete "/books/#{book1.id}" }
    before { book1 }

    it 'returns http status of :no_content' do
      book_delete_request
      expect(response).to have_http_status :no_content
    end

    it 'deletes the book' do
      expect {
        book_delete_request 
      }.to change { Book.count }.from(1).to(0)
    end
  end
end
