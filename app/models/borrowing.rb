class Borrowing < ApplicationRecord
  belongs_to :book
  belongs_to :reader
  validates :borrow_date, presence: true
  
end
