class DueDayMailerPreview < ActionMailer::Preview
  def three_days_email
    borrowing = Borrowing.first
    DueDayMailer.three_days_email(borrowing)
  end

  def due_day_email
    borrowing = Borrowing.first
    DueDayMailer.due_day_email(borrowing)
  end
end
