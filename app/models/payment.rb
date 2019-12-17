class Payment < ApplicationRecord
  belongs_to :loan
  enum state: [:pending, :paid]

  private

  def self.send_payment_emails
    payment = Payment.last
    puts "BEGIN"
    #Payment.where(created_at: 24.hours.ago..Time.now) do |payment|
      PaymentMailer.new_payment_email(payment).deliver_now
    #end
     puts "DONE"
  end
end
