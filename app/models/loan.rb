class Loan < ApplicationRecord
  belongs_to :lender
  belongs_to :debtor

  enum payback_type: [:monthly, :monthly_with_static_return  , :preferential]
end
