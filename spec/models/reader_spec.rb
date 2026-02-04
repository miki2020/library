require 'rails_helper'

RSpec.describe Reader, type: :model do
  describe 'validations' do
    subject { Reader.new(name: "Sample Reader", email: "sample@example.com") }
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end
end
