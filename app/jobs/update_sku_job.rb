require 'net/http'

class UpdateSkuJob < ApplicationJob
  queue_as :default

  def perform(book_title)
    uri = URI('http://localhost:3001/update_sku')
    req = Net::HTTP::Post.new(uri, 'Content-type': 'application/json')
    req.body = { sku: '123', title: book_title }.to_json
    Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end
end
