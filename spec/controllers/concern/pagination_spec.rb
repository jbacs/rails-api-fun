require 'rails_helper'

RSpec.describe Pagination, type: :controller do
  controller(Api::V1::BooksController) {}

  context '#limit' do
    it 'has a max limit of 100' do
      expect(Book).to receive(:limit).with(100).and_call_original

      get :index, params: { limit: 999 }
    end
  end
end