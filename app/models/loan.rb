class Loan < ApplicationRecord
  belongs_to :lender, class_name: 'User'
  belongs_to :debtor, class_name: 'User'
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
    sum = self.sum + (self.sum * 0.01 * self.percentage  )
    pay_until = self.created_at.to_date + 1.month

    CreatePaymentWorker.perform_async(sum, pay_until, self.id)
  end
end
