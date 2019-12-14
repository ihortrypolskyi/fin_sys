class Payment < ApplicationRecord
  belongs_to :loan
  enum state: [:pending, :paid]

  def create_payment
    @payment = Payment.new(order_params)

    if @payment.save
      PaymentMailer.with(payment: @payment).new_payment_email.deliver_later
    end
  end

end
