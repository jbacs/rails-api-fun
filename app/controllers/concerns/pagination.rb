module Pagination
  extend ActiveSupport::Concern

  PAGITNATION_LIMIT = 100

  def limit
    [params.fetch(:limit, PAGITNATION_LIMIT).to_i, PAGITNATION_LIMIT].min
  end
end