class Payment < ApplicationRecord
  belongs_to :loan
  enum state: [:pending, :paid]

  private

  def self.send_payment_emails
    Payment.where(created_at: 24.hours.ago..Time.now) do |payment|
      PaymentMailer.new_payment_email(payment).deliver_later
    end
  end
end
