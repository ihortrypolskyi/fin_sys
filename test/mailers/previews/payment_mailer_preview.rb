# Preview all emails at http://localhost:3000/rails/mailers/loan_mailer
class PaymentMailerPreview < ActionMailer::Preview
  def new_payment_email
    payment = Payment.last
    PaymentMailer.new_payment_email(payment)
  end
end
