require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'Association' do
    it { should have_many :books }
  end

  context 'Validation' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :age }
  end
end
