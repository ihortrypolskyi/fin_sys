class Payment < ApplicationRecord
  belongs_to :loan
  enum state: [:pending, :paid]

  private

  def self.check_payment_email_to_send

  end

  def self.send_payment_email
     PaymentMailer.new_payment_email(self).deliver_later
    #Payment.last.update!(sum: 2)
  end

end
