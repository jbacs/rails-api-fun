require 'rails_helper'

RSpec.describe UpdateSkuJob, type: :job do
  let(:book_title) { Faker::Book.title }

  it 'calls SKU service with corrent params' do
    allow(Net::HTTP).to receive(:start).and_return(true)
    expect_any_instance_of(Net::HTTP::Post).to receive(:body=).with(
      { sku: '123', title: book_title }.to_json
    )

    described_class.perform_now(book_title)
  end
end
