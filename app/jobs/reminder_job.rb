class ReminderJob < ApplicationJob
  queue_as :default

  def perform
    borrownings = Borrowing.where(due_date: 3.days.from_now.to_date)
    borrownings.each do |borrowing|
      DueDayMailer.three_days_email(borrowing).deliver_later
    end

    borrownings = Borrowing.where(due_date: Date.today)
    borrownings.each do |borrowing|
      DueDayMailer.due_day_email(borrowing).deliver_later
    end
  end
end
