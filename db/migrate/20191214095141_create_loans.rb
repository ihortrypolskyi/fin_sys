class CreateLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :loans do |t|
      t.float :sum, null: false
      t.integer :percentage
      t.integer :payback_type, null: false
      t.integer :number_of_months
      t.float :static_return_value
      t.float :pay_sum
      t.float :paid_back_sum
      t.integer :lender_id
      t.integer :debtor_id

      t.timestamps
    end
  end
end
