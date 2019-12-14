class Debtor < User
  has_many :loans
  has_many :lenders, through: :loans

end
