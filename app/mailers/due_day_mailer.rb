class DueDayMailer < ApplicationMailer
  default from: "no-reply@library.com"

  def due_day_email(borrowing)
    @borrowing = borrowing
    @reader = borrowing.reader
    @book = borrowing.book
    mail(to: @reader.email, subject: "Reminder: Book Due Today")
  end

  def three_days_email(borrowing)
    @borrowing = borrowing
    @reader = borrowing.reader
    @book = borrowing.book
    mail(to: @reader.email, subject: "Reminder: Book Due in Three Days")
  end
end
