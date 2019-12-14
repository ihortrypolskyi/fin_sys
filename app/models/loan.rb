class Loan < ApplicationRecord
  belongs_to :lender, class_name: 'User'
  belongs_to :debtor, class_name: 'User'
  validates :lender_id, presence: true
  validates :debtor_id, presence: true

  enum payback_type: [:monthly, :monthly_with_static_return  , :preferential]

  def custom_column
    self.lender.first_name
  end

  def loan_name
    "#{self.sum}  #{self.lender.first_name} #{self.debtor.first_name} "
  end
end
