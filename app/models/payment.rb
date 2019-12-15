class Payment < ApplicationRecord
  belongs_to :loan
  enum state: [:pending, :paid]

  after_create :send_payment_email

  #TODO sender email

  private

  def send_payment_email
     PaymentMailer.new_payment_email(self).deliver_later
  end

end
