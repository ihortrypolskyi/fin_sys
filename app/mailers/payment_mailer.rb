class PaymentMailer < ApplicationMailer
  #def new_payment_email(payment)
  def new_payment_email
  #  @payment = payment
    payment = Payment.last
    @loan_sum = payment.loan.sum
    @lender_name = payment.loan.lender.first_name
    @loan_percentage = payment.loan.percentage
    @payment_sum = payment.sum
    @pay_until = payment.pay_until
    @static_return_value =  payment.loan.static_return_value

    #TODO add debtor_email to payment
    @debtor_email = payment.loan.debtor.email
    mail(to: "#{@debtor_email}", subject: "New payment created")
  end
end
