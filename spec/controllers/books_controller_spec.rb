require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  describe 'POST create' do
    let(:author_build) { build :author }
    let(:book_build) { build :book }

    it 'calls UpdateSkuJob with correct params' do
      expect(UpdateSkuJob).to receive(:perform_later).with(book_build.title)

      post :create, params: {
        book: { title: book_build.title },
        author: { first_name: author_build.first_name, last_name: author_build.last_name, age: author_build.age }
      }
    end
  end
end