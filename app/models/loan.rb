class Loan < ApplicationRecord
  belongs_to :lender, class_name: 'User'
  belongs_to :debtor, class_name: 'User'
  has_many :payments

  validates_presence_of :sum, :payback_type, :percentage, :number_of_months
  validates_numericality_of :sum, :number_of_months, :percentage, :greater_than => 0
  validates_numericality_of :paid_back_sum, :greater_than => 0, :allow_nil => true



  after_create :create_loan_payment

  enum payback_type: [:monthly, :monthly_with_static_return  , :preferential]

  def lender_name
    self.lender.full_name
  end

  def debtor_name
    self.debtor.full_name
  end

  private


  def run_payment_worker(sum_to_pay, pay_until, loan_id)
    CreatePaymentWorker.perform_async(sum_to_pay, pay_until, loan_id)
  end

  def calculate_static_return(monthly_sum_to_pay)
    self.update!(static_return_value: monthly_sum_to_pay)
  end


  def create_loan_payment
    percentage = self.percentage
    number_of_months = self.number_of_months
    sum_to_go = self.sum
    months_to_go = self.number_of_months
    pay_until = self.created_at
    current_debt = sum_to_go + (sum_to_go * 0.01 * percentage)
    monthly_sum_to_pay = current_debt/number_of_months

    case self.payback_type
    when 'monthly'
      loan_id = self.id

      i = 0
      while i < number_of_months do
        current_debt = sum_to_go + (sum_to_go * 0.01 * percentage)
        monthly_sum_to_pay = current_debt/months_to_go
        months_to_go -= 1
        sum_to_go = current_debt - monthly_sum_to_pay
        pay_until = pay_until + 2.months
        i += 1

        run_payment_worker(monthly_sum_to_pay, pay_until, loan_id)
      end
      
    when 'monthly_with_static_return'
      loan_id = self.id


      i = 0
      while i < number_of_months do
        pay_until = pay_until + 2.months
        i += 1
        run_payment_worker(monthly_sum_to_pay, pay_until, loan_id)
      end

      calculate_static_return(monthly_sum_to_pay)

    when 'preferential'
      loan_id = self.id
      pay_until = pay_until + 12.months
      run_payment_worker(current_debt, pay_until, loan_id)
      
    else
      begin
        raise Exception.new
      rescue Exception => error
        puts "No payback_type for Loan id: #{self.id} "
      end
    end
  end
end
