# Preview all emails at http://localhost:3000/rails/mailers/loan_mailer
class PaymentMailerPreview < ActionMailer::Preview
  def new_payment_email
    # Set up a temporary payment for the preview
    #payment = Payment.last(sum: 100, email: "joe@gmail.com", address: "1-2-3 Chuo, Tokyo, 333-0000", phone: "090-7777-8888", message: "I want to place an payment!")
    payment = Payment.new(sum: 100)

    PaymentMailer.with(payment: payment).new_payment_email
  end
end
