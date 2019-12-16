class Loan < ApplicationRecord
  belongs_to :lender, class_name: 'User'
  belongs_to :debtor, class_name: 'User'
  has_many :payments
  # validates :lender_id, presence: true
  # validates :debtor_id, presence: true
  #TODO sums scale
  after_create :create_loan_payment

  enum payback_type: [:monthly, :monthly_with_static_return  , :preferential]

  def lender_name
    self.lender.full_name
  end

  def debtor_name
    self.debtor.full_name
  end

  private

  def create_loan_payment
    case self.payback_type
    when 'monthly'
      percentage = self.percentage
      number_of_months = self.number_of_months
      sum_to_go = self.sum
      months_to_go = self.number_of_months
      pay_until = self.created_at

      i = 0
      while i < number_of_months do
        current_debt = sum_to_go + (sum_to_go * 0.01 * percentage)
        monthly_sum_to_pay = current_debt/months_to_go
        months_to_go -= 1
        sum_to_go = current_debt - monthly_sum_to_pay
        pay_until = pay_until + 2.months
        i += 1

        Payment.create!(sum: monthly_sum_to_pay, pay_until: pay_until, loan_id: self.id)
      end
    when 'monthly_with_static_return'
    when 'preferential'
    else
    end
    #
    #run_payment_worker

  end

  def run_payment_worker
    CreatePaymentWorker.perform_async(sum, pay_until, self.id)
  end


end
