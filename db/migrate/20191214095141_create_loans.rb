class CreateLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :loans do |t|
      t.float :sum, null: false
      t.integer :percentage
      t.integer :payback_type, null: false, default: 0
      t.integer :number_of_months
      t.float :static_return_value
      t.float :pay_sum
      t.float :paid_back_sum

      t.references :lender, null: false, foreign_key: true
      t.references :debtor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
