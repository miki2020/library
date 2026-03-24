class Borrowing < ApplicationRecord
  belongs_to :book
  belongs_to :reader
  validates :borrow_date, presence: true

  validate double_borrowing, on: :create

  private

  def double_borrowing
    return unless book_id.present?
    if Borrowing.where(book_id: book_id, return_date: nil).exists?
      errors.add(:base, "This book is already borrowed.")
    end
  end
end
