desc "Send_payment_emails on Heroku"
task :send_payment_emails => :environment do
  Payment.send_payment_emails
end