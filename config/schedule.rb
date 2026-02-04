# Use this file to easily define all of your cron jobs.
# Learn more: http://github.com/javan/whenever

# Set the environment (defaults to production)
set :environment, ENV.fetch("RAILS_ENV", "production")

# Set the output for cron job logs
set :output, "log/cron.log"

# Run the ReminderJob daily at 8:00 AM
every 1.day, at: "8:00 am" do
  runner "ReminderJob.perform_later"
end
