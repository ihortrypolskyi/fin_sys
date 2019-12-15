class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:admin, :lender, :debtor]
  has_many :lender_loans, class_name:  "Loan", foreign_key: "lender_id"
  has_many :debtor_loans, class_name:  "Loan", foreign_key: "debtor_id"
  has_many :lenders, through: :lender_loans
  has_many :debtors, through: :debtor_loans

  validates :first_name, :last_name, :role, presence: true

  after_create :create_full_name

  private

  def create_full_name
    self.update!(full_name: "#{self.first_name} #{self.last_name}")
  end
end
