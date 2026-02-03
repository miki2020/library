class Reader < ApplicationRecord
  before_validation :generate_card_number, on: :create

  validates :card_number,
            presence: true,
            uniqueness: true,
            format: { with: /\A\d{6}\z/, message: "must be 6 digits" }
  validates :name, presence: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  private

  def generate_card_number
    last_number = Reader.maximum(:card_number).to_i
    self.card_number = "%06d" % (last_number + 1)
  end
end
