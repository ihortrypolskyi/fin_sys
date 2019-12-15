class CreatePaymentWorker
  include Sidekiq::Worker
  sidekiq_options retry:false

  def perform(sum, pay_until, loan_id)
    Payment.create!(sum: sum, pay_until: pay_until, loan_id: loan_id)
  end
end