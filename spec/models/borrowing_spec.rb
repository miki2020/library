require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  describe 'validations' do
    let(:reader) { Reader.create!(name: 'Test Reader', email: 'test@example.com') }
    let(:book) { Book.create!(title: 'Test Book', author: 'Test Author') }
    subject do
      Borrowing.new(
        book: book,
        reader: reader,
        borrow_date: Date.today
      )
    end
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end
end
