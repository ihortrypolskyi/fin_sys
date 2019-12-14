class Payment < ApplicationRecord
  belongs_to :loan
  enum state: [:pending, :paid]
end
