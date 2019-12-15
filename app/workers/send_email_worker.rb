#TODO delete
#class SendEmailWorker
#  include Sidekiq::Worker
#  sidekiq_options retry:false
#
#  def perform(sum, loan_id)
#    #PaymentMailer.with(payment: @payment).new_payment_email.deliver_later
#    PaymentMailer.with(sum: sum).new_payment_email(self).deliver_now
#  end
#end