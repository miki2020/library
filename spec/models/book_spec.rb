require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    subject { Book.new(title: "Sample Book", author: "Author Name") }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:title]).to include("can't be blank")
    end

    it 'is not valid without an author' do
      subject.author = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:author]).to include("can't be blank")
    end

    it 'generates a serial number on creation' do
      subject.save
      expect(subject.serial_number).to match(/\A\d{6}\z/)
    end
  end
end
