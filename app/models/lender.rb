class Lender < User
  has_many :loans
  has_many :debtors, through: :loans
end
