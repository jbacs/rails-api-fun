require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'Association' do
    it { should belong_to :author }
  end

  context 'Validation' do
    it { should validate_presence_of :title }
  end
end
