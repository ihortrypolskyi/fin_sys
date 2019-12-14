class PaymentMailer < ApplicationMailer
  def new_payment_email
    #@payment = params[:payment]
    @payment = Payment.last
    @debtor_email = @payment.loan.debtor.email
    mail(to: "#{@debtor_email}", subject: "New payment created")
  end
end
