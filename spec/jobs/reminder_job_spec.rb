require 'rails_helper'

RSpec.describe ReminderJob, type: :job do
  describe '#perform' do
    let(:reader) { Reader.create!(name: 'Test Reader', email: 'test@example.com') }
    let(:book1) { Book.create!(title: 'Book 1', author: 'Author 1') }
    let(:book2) { Book.create!(title: 'Book 2', author: 'Author 2') }
    let(:book3) { Book.create!(title: 'Book 3', author: 'Author 3') }

    let(:mail_double) { double('mail', deliver_later: true) }

    before do
      # Stub all mailer methods to avoid actual email sending
      allow(DueDayMailer).to receive(:three_days_email).and_return(mail_double)
      allow(DueDayMailer).to receive(:due_day_email).and_return(mail_double)
    end

    context 'when there are borrowings due in 3 days' do
      before do
        # due_date = borrow_date + 30 days
        Borrowing.create!(
          book: book1,
          reader: reader,
          borrow_date: 3.days.from_now.to_date - 30.days
        )
      end

      it 'sends a 3-day reminder email' do
        described_class.perform_now

        expect(DueDayMailer).to have_received(:three_days_email)
      end
    end

    context 'when there are borrowings due today' do
      before do
        Borrowing.create!(
          book: book2,
          reader: reader,
          borrow_date: Date.today - 30.days
        )
      end

      it 'sends a due day email' do
        described_class.perform_now

        expect(DueDayMailer).to have_received(:due_day_email)
      end
    end

    context 'when there are borrowings due in 7 days' do
      before do
        Borrowing.create!(
          book: book3,
          reader: reader,
          borrow_date: 7.days.from_now.to_date - 30.days
        )
      end

      it 'does not send any emails' do
        described_class.perform_now

        expect(DueDayMailer).not_to have_received(:three_days_email)
        expect(DueDayMailer).not_to have_received(:due_day_email)
      end
    end

    it 'enqueues the job on the default queue' do
      expect {
        described_class.perform_later
      }.to have_enqueued_job(described_class).on_queue('default')
    end
  end
end
