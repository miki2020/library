class Book < ApplicationRecord
  before_validation :generate_serial_number, on: :create
  after_initialize :set_borrowed_status

  validates :serial_number,
            presence: true,
            uniqueness: true,
            format: { with: /\A\d{6}\z/, message: "must be 6 digits" }
  validates :title, presence: true
  validates :author, presence: true
  has_many :borrowings, dependent: :destroy

  attr_reader :borrowed

  private

  def generate_serial_number
    last_number = Book.maximum(:serial_number).to_i
    self.serial_number = "%06d" % (last_number + 1)
  end

  def set_borrowed_status
    @borrowed = borrowed?
  end

  def borrowed?
    return false if new_record?
    borrowings.where(return_date: nil).exists?
  end
end
